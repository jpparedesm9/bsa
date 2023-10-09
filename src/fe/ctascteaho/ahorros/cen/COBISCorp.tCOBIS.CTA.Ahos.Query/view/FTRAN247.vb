Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTran247Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Public VLCtaNoMask As String = ""

    Private Sub FTran247_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        CargaFormatoFecha()
        VLCtaNoMask = mskCuenta.Text
        mskCuenta.Text = FMMascara(mskCuenta.Text, VGMascaraCtaAho)
        mskCuenta_Leave(Nothing, Nothing)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim bandera As Boolean = False
        Dim contadorRegAnterior As Integer = 0
        Dim primVez As Boolean = False
        Select Case Index
            Case 0 'BUSCAR
                If mskCuenta.ClipText <> "" Then
                    contadorRegAnterior = 0
                    bandera = True
                    primVez = True
                    While bandera
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "247")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VLCtaNoMask) 'mskCuenta.ClipText
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If primVez Then
                            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, "0")
                        Else
                            grdRegistros.Row = grdRegistros.Rows - 1
                            grdRegistros.Col = 1
                            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                        End If
                        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_cons_valsus", True, FMLoadResString(502621)) Then '" Ok... Consulta de valores en suspenso"
                            If primVez Then
                                PMMapeaObjetoAB(sqlconn, lblDescripcion(1), lblDescripcion(2))
                                PMMapeaGrid(sqlconn, grdRegistros, False)
                                primVez = False
                            Else
                                PMMapeaGrid(sqlconn, grdRegistros, True)
                            End If
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                        End If
                        If grdRegistros.Rows >= (contadorRegAnterior + 20) Then
                            contadorRegAnterior = grdRegistros.Rows - 1
                        Else
                            bandera = False
                        End If
                    End While
                    If grdRegistros.Rows > 2 Then
                        For i As Integer = 1 To grdRegistros.Rows - 1
                            grdRegistros.Row = i
                            grdRegistros.Col = 8
                            If grdRegistros.CtlText = "C" Then
                                grdRegistros.Col = 6
                            Else
                                grdRegistros.Col = 6
                            End If
                        Next i
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"El número de Cuenta de Ahorros es mandatorio"
                    mskCuenta.Focus()
                End If
            Case 1 'LIMPIAR
                For i As Integer = 1 To 2
                    lblDescripcion(i).Text = ""
                Next i
                PMLimpiaGrid(grdRegistros)
            Case 2 'SALIR
                Me.Close()
        End Select
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VLCtaNoMask) 'mskCuenta.ClipText
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502972) & "[" & mskCuenta.Text & "]") Then 'Ok... Consulta la cuenta
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    PMChequea(sqlconn)
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) ' "El dígito verificador de la cuenta de ahorros está incorrecto"
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        Me.Text = FMLoadResString(509514)
    End Sub

    Private Sub FTran247_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659)) '" Número de la Cuenta de Ahorros"
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509061))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


