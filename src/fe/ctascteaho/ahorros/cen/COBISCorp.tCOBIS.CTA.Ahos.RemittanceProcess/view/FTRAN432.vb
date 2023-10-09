Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 public  Partial  Class FTran432Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLSalir As Boolean = False
	Dim VLStatus As String = ""
	Dim VLRef As String = ""
	Dim VLVez As Integer = 0
	Dim VLConfirmar As String = ""

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdBoton.Click
		Me.Close()
	End Sub

	Private Sub FTran432_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBSalir.Enabled = cmdBoton.Enabled
        TSBSalir.Visible = cmdBoton.Visible
    End Sub

    Public Sub PLInicializar()
        Dim VTArreglo(20) As String
        VLSalir = False
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "407")
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, VGADatosI(1))
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_status", 0, SQLVARCHAR, VLStatus)
            PMPasoValores(sqlconn, "@i_ref", 0, SQLINT4, VLRef)
            PMPasoValores(sqlconn, "@i_vez", 0, SQLINT1, Conversion.Str(VLVez))
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_consulcar", True, FMLoadResString(508809)) Then
                If VLVez = 1 Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaVariable(sqlconn, VLConfirmar)
                Else
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                End If
                PMChequea(sqlconn)
                VLVez += 1
                If CDbl(Convert.ToString(grdRegistros.Tag)) < 40 Then VLSalir = True
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
                FTran410.grdRegistros.Col = 1
                lblDescripcion(10).Text = FTran410.grdRegistros.CtlText
                FTran410.grdRegistros.Col = 2
                lblDescripcion(11).Text = FTran410.grdRegistros.CtlText
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 6
                VLStatus = grdRegistros.CtlText
                grdRegistros.Col = 7
                VLRef = grdRegistros.CtlText
            Else                
                PMChequea(sqlconn)
                VLSalir = True
            End If
        End While
    End Sub

	Private Sub FTran432_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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

        grdRegistros.Col = 0
		If grdRegistros.CtlText <> "X" Then
			grdRegistros.CtlText = "X"
		Else
			If grdRegistros.CtlText = "X" Then
				grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
			End If
		End If
	End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        Me.Close()
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5120))

    End Sub


    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


