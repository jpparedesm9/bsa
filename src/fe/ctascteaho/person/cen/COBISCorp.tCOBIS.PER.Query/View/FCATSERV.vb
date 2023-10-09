Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Partial Public Class FCatalogoServClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Public FContratacion As Object
    Public FconVarCosto As Object
    Public FMantenLinea2 As Object
    Public FConsulMas As Object
    Public FConsulMas2 As Object
    Public FRubros As Object
    Public FConsultaCta As Object

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        grdRegistros.Row = grdRegistros.Rows - 1
        Select Case VGOperacion
            Case "operacionHCont", "operacionHCons"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1596)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    If CDbl(Convert.ToString(Me.grdRegistros.Tag)) <> 20 Then
                        cmdSiguientes.Enabled = False
                        PLTSEstado()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case "FCONVAR2-1"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1596)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    If CDbl(Convert.ToString(Me.grdRegistros.Tag)) <> 20 Then
                        cmdSiguientes.Enabled = False
                        PLTSEstado()
                    End If
                End If
            Case "operacionH2Cont", "operacionH2Cons"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1596)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub


    Private Sub FCatalogoServ_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 27 Then
            Select Case VGOperacion
                Case "operacionHCons", "operacionH2Cons"
                    FConsultaCta = Me.Owner()
                    FConsultaCta.txtCampo(1).Text = ""
                    FConsultaCta.lblDescripcion(6).Text = ""
                    FConsultaCta.txtCampo(3).Text = ""
                    FConsultaCta.lblDescripcion(7).Text = ""
                Case "operacionHCont", "operacionH2Cont"
                    FContratacion = Me.Owner()
                    FContratacion.txtCampo(5).Text = ""
                    FContratacion.lblDescripcion(8).Text = ""
                    FContratacion.txtCampo(6).Text = ""
                    FContratacion.lblDescripcion(9).Text = ""
            End Select
            Me.Close()
        Else
            If KeyAscii = 13 Then
                grdRegistros_DoubleClick(grdRegistros, New EventArgs())
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
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
        If Me.grdRegistros.Rows <> 0 Then
            Select Case VGOperacion
                Case "operacionHCons", "operacionH2Cons"
                    FConsultaCta = Me.Owner()
                    grdRegistros.Col = 1
                    FConsultaCta.txtCampo(1).Text = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    FConsultaCta.lblDescripcion(6).Text = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    FConsultaCta.txtCampo(3).Text = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    FConsultaCta.lblDescripcion(7).Text = grdRegistros.CtlText
                Case "operacionHCont", "operacionH2Cont"
                    FContratacion = Me.Owner()
                    grdRegistros.Col = 1
                    FContratacion.txtCampo(5).Text = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    FContratacion.lblDescripcion(8).Text = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    FContratacion.txtCampo(6).Text = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    FContratacion.lblDescripcion(9).Text = grdRegistros.CtlText
                Case "FCONVAR2-1", "FCONVAR2-2"
                    FconVarCosto = Me.Owner()
                    grdRegistros.Col = 1
                    FconVarCosto.txtCampo(0).Text = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    FconVarCosto.lblDescripcion(1).Text = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    FconVarCosto.lblDescripcion(11).Text = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    FconVarCosto.lblDescripcion(5).Text = grdRegistros.CtlText
            End Select
        Else
            Select Case VGOperacion
                Case "operacionHCons", "operacionH2Cons"
                    FConsultaCta = Me.Owner()
                    FConsultaCta.txtCampo(1).Text = ""
                    FConsultaCta.lblDescripcion(6).Text = ""
                    FConsultaCta.txtCampo(3).Text = ""
                    FConsultaCta.lblDescripcion(7).Text = ""
                Case "operacionHCont", "operacionH2Cont"
                    FContratacion = Me.Owner()
                    FContratacion.txtCampo(5).Text = ""
                    FContratacion.lblDescripcion(8).Text = ""
                    FContratacion.txtCampo(6).Text = ""
                    FContratacion.lblDescripcion(9).Text = ""
                Case "FCONVAR2-1", "FCONVAR2-2"
                    FconVarCosto = Me.Owner()
                    FconVarCosto.txtCampo(0).Text = ""
                    FconVarCosto.lblDescripcion(1).Text = ""
                    FconVarCosto.lblDescripcion(11).Text = ""
                    FconVarCosto.lblDescripcion(5).Text = ""
            End Select
        End If
        Me.Close()
    End Sub

    Private Sub FCatalogoServ_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
        If grdRegistros.Rows >= 2 Then grdRegistros.Row = 1
        PMAnchoColumnasGrid(grdRegistros)
    End Sub

    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = cmdSiguientes.Enabled
        TSBSiguientes.Visible = cmdSiguientes.Visible
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If cmdSiguientes.Enabled Then cmdSiguientes_Click(cmdSiguientes, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        'cmdSiguientes.Enabled = Not (Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20)
        If Val(grdRegistros.Tag) < 20 Then
            cmdSiguientes.Enabled = False
        Else
            cmdSiguientes.Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private Sub TSBEscoger_Click(sender As Object, e As EventArgs) Handles TSBEscoger.Click
        grdRegistros_DoubleClick(grdRegistros, New EventArgs)
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        Me.Close()
    End Sub

End Class


