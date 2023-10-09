Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FAyudaSubservClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Public FRubros As Object
	Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTCodigo As String = string.Empty
		Dim  VTRubro As String = string.Empty
		Select Case Index
            Case 0
                FRubros = Me.Owner()
                If FRubros.txtCampo(0).Text <> "" Then
                    VTFilas = VGMaxRows
                    VTCodigo = FRubros.txtCampo(0).Text
                    VTRubro = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4039")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                        PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, VTRubro)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_cosub", True, FMLoadResString(1551)) Then
                            If VTRubro = "0" Then
                                PMMapeaGrid(sqlconn, grdSubserv, False)
                            Else
                                PMMapeaGrid(sqlconn, grdSubserv, True)
                            End If
                            PMMapeaTextoGrid(grdSubserv)
                            PMAnchoColumnasGrid(grdSubserv)
                            PMChequea(sqlconn)
                            grdSubserv.Col = 3
                            grdSubserv.Row = grdSubserv.Rows - 1
                            VTRubro = grdSubserv.CtlText
                            If Conversion.Val(Convert.ToString(grdSubserv.Tag)) > 0 Then
                                cmdEscoger.Enabled = True
                            Else
                                If VTRubro = "0" Then
                                    FRubros.lblDescripcion(1).Text = ""
                                    FRubros.lblDescripcion(11).Text = ""
                                    FRubros.lblDescripcion(5).Text = ""
                                End If
                            End If
                        Else
                            PMChequea(sqlconn)
                        End If
                        VTFilas = Conversion.Val(Convert.ToString(grdSubserv.Tag))
                    End While
                    grdSubserv.Row = 1
                Else
                    VTFilas = VGMaxRows
                    VTCodigo = "0"
                    VTRubro = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4039")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H1")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                        PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, VTRubro)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_cosub", True, FMLoadResString(1551)) Then
                            If VTCodigo = "0" Then
                                PMMapeaGrid(sqlconn, grdSubserv, False)
                            Else
                                PMMapeaGrid(sqlconn, grdSubserv, True)
                            End If
                            PMMapeaTextoGrid(grdSubserv)
                            PMChequea(sqlconn)
                            grdSubserv.Col = 3
                            grdSubserv.Row = grdSubserv.Rows - 1
                            VTCodigo = grdSubserv.CtlText
                            grdSubserv.Col = 4
                            grdSubserv.Row = grdSubserv.Rows - 1
                            VTRubro = grdSubserv.CtlText
                            If Conversion.Val(Convert.ToString(grdSubserv.Tag)) > 0 Then
                                cmdEscoger.Enabled = True
                            End If
                        Else
                            PMChequea(sqlconn)
                        End If
                        VTFilas = Conversion.Val(Convert.ToString(grdSubserv.Tag))
                    End While
                    grdSubserv.Row = 1
                 
                End If
        End Select
          PLTSEstado()
	End Sub

	Private Sub cmdBuscar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_0.Enter
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1029))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1031))
		End Select
	End Sub

	Private Sub cmdEscoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Click
		grdSubserv_DoubleClick(grdSubserv, New EventArgs())
	End Sub

	Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1327))
	End Sub

	Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
		ReDim VGDetalle(1)
        VGDetalle(1) = ""
        Me.Close()
	End Sub

	Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1698))
	End Sub

	Private Sub FAyudaSubserv_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1039))
        cmdBuscar_Click(cmdBuscar(0), New EventArgs())
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
	End Sub

	Private Sub FAyudaSubserv_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdSubserv_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdSubserv.ClickEvent
        grdSubserv.Col = 0
        grdSubserv.SelStartCol = 1
        grdSubserv.SelEndCol = grdSubserv.Cols - 1
        If grdSubserv.Row = 0 Then
            grdSubserv.SelStartRow = 1
            grdSubserv.SelEndRow = 1
        Else
            grdSubserv.SelStartRow = grdSubserv.Row
            grdSubserv.SelEndRow = grdSubserv.Row
        End If
    End Sub

	Private Sub grdSubserv_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdSubserv.DblClick
		Dim VTRow As Integer = grdSubserv.Row
		grdSubserv.Row = 1
		grdSubserv.Col = 1
		If grdSubserv.CtlText <> "" Then
			grdSubserv.Row = VTRow
			PMMarcarDetalle()
		End If
	End Sub

	Private Sub grdSubserv_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdSubserv.KeyUp
        grdSubserv.Col = 0
		grdSubserv.SelStartCol = 1
		grdSubserv.SelEndCol = grdSubserv.Cols - 1
		If grdSubserv.Row = 0 Then
			grdSubserv.SelStartRow = 1
			grdSubserv.SelEndRow = 1
		Else
			grdSubserv.SelStartRow = grdSubserv.Row
			grdSubserv.SelEndRow = grdSubserv.Row
		End If
	End Sub

	Private Sub PMMarcarDetalle()
		Dim VTCols As Integer = grdSubserv.Cols - 1
		ReDim VGDetalle(VTCols)
		VGDetalle(0) = "S"
		For i As Integer = 1 To grdSubserv.Cols - 1
			grdSubserv.Col = i
			VGDetalle(i) = grdSubserv.CtlText
		Next i
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
		Me.Close()
	End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBuscar_0.Enabled
        TSBBuscar.Visible = _cmdBuscar_0.Visible
        TSBEscoger.Enabled = cmdEscoger.Enabled
        TSBEscoger.Visible = cmdEscoger.Visible
        TSBSalir.Enabled = cmdSalir.Enabled
        TSBSalir.Visible = cmdSalir.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar_0.Enabled Then cmdBuscar_Click(_cmdBuscar_0, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If cmdEscoger.Enabled Then cmdEscoger_Click(cmdEscoger, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If cmdSalir.Enabled Then cmdSalir_Click(cmdSalir, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdSubserv_Enter(sender As Object, e As EventArgs) Handles grdSubserv.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdSubserv_Leave(sender As Object, e As EventArgs) Handles grdSubserv.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


