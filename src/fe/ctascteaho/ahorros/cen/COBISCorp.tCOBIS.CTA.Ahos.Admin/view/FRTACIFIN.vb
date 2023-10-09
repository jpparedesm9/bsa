Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FRTACIFINClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        Me.Close()
    End Sub

    Private Sub FRTACIFIN_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        PLConsultaCIFIN()
        PLTSEstado()
    End Sub

    Private Sub PLConsultaCIFIN()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1468")
        PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, FTranUpGMF.mskCuenta.ClipText)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_consulta_rta_cifin", True, FMLoadResString(503282)) Then
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            For i As Integer = 1 To lblDescripcion.GetUpperBound(0)
                lblDescripcion(i).Text = VTArreglo(i)
            Next
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBSalir.Visible = cmdSalir.Visible
        TSBSalir.Enabled = cmdSalir.Enabled
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If cmdSalir.Enabled Then cmdSalir_Click(cmdSalir, e)
    End Sub
End Class


