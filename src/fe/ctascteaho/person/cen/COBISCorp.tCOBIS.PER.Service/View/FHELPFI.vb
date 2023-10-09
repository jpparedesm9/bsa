Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FAyudaProdFinalClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTCodigo As String = string.Empty
		Dim  VTProducto As String = string.Empty
		Dim  VTMoneda As String = string.Empty
		Select Case Index
			Case 0
				Select Case VGProd
					Case "R"
						If FRubros.txtCampo(2).Text <> "" Then
							VTFilas = VGMaxRows
							VTCodigo = FRubros.txtCampo(2).Text
							VTProducto = "0"
							VTMoneda = "0"
							While VTFilas = VGMaxRows
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4077")
								PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
								PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, VTCodigo)
								PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
								PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                                    If VTProducto = "0" Then
                                        PMMapeaGrid(sqlconn, grdProductos, False)
                                    Else
                                        PMMapeaGrid(sqlconn, grdProductos, True)
                                    End If
                                    PMMapeaTextoGrid(grdProductos)
                                    PMChequea(sqlconn)
                                    VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                                    If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                                        cmdEscoger.Enabled = True
                                    Else
                                        If VTProducto = "0" Then
                                            FRubros.lblDescripcion(0).Text = ""
                                            FRubros.lblDescripcion(2).Text = ""
                                            FRubros.lblDescripcion(4).Text = ""
                                            FRubros.lblDescripcion(6).Text = ""
                                            FRubros.lblDescripcion(7).Text = ""
                                            FRubros.lblDescripcion(8).Text = ""
                                            FRubros.lblDescripcion(10).Text = ""
                                        End If
                                    End If
                                    grdProductos.Col = 2
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTProducto = grdProductos.CtlText
                                    grdProductos.Col = 4
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTMoneda = grdProductos.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    Exit Sub
                                End If
							End While
							grdProductos.Row = 1
						Else
							VTFilas = VGMaxRows
							VTCodigo = "0"
							VTProducto = "0"
							VTMoneda = "0"
							While VTFilas = VGMaxRows
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
								PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
								PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, VTCodigo)
								PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
								PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                                    If VTCodigo = "0" Then
                                        PMMapeaGrid(sqlconn, grdProductos, False)
                                    Else
                                        PMMapeaGrid(sqlconn, grdProductos, True)
                                    End If
                                    PMMapeaTextoGrid(grdProductos)
                                    PMChequea(sqlconn)
                                    VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                                    If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                                        cmdEscoger.Enabled = True
                                    End If
                                    grdProductos.Col = 2
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTCodigo = grdProductos.CtlText
                                    grdProductos.Col = 4
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTProducto = grdProductos.CtlText
                                    grdProductos.Col = 6
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTMoneda = grdProductos.CtlText
                                Else
                                    PMChequea(sqlconn)
                                End If
							End While
							grdProductos.Row = 1
						End If
					Case "C"
						If FContratacion.txtCampo(2).Text <> "" Then
							VTFilas = VGMaxRows
							VTCodigo = FContratacion.txtCampo(2).Text
							VTProducto = "0"
							VTMoneda = "0"
							While VTFilas = VGMaxRows
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4077")
								PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
								PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, VTCodigo)
								PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
								PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                                    If VTProducto = "0" Then
                                        PMMapeaGrid(sqlconn, grdProductos, False)
                                    Else
                                        PMMapeaGrid(sqlconn, grdProductos, True)
                                    End If
                                    PMMapeaTextoGrid(grdProductos)
                                    PMChequea(sqlconn)
                                    VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                                    If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                                        cmdEscoger.Enabled = True
                                    Else
                                        If VTProducto = "0" Then
                                            FContratacion.lblDescripcion(2).Text = ""
                                            FContratacion.lblDescripcion(3).Text = ""
                                            FContratacion.lblDescripcion(4).Text = ""
                                            FContratacion.lblDescripcion(6).Text = ""
                                        End If
                                    End If
                                    grdProductos.Col = 2
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTProducto = grdProductos.CtlText
                                    grdProductos.Col = 4
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTMoneda = grdProductos.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    FContratacion.txtCampo(2).Text = ""
                                    Exit Sub
                                End If
							End While
							grdProductos.Row = 1
						Else
							VTFilas = VGMaxRows
							VTCodigo = "0"
							VTProducto = "0"
							VTMoneda = "0"
							While VTFilas = VGMaxRows
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
								PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S2")
								PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, VTCodigo)
								PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
								PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                                    If VTCodigo = "0" Then
                                        PMMapeaGrid(sqlconn, grdProductos, False)
                                    Else
                                        PMMapeaGrid(sqlconn, grdProductos, True)
                                    End If
                                    PMMapeaTextoGrid(grdProductos)
                                    PMChequea(sqlconn)
                                    VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                                    If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                                        cmdEscoger.Enabled = True
                                    End If
                                    grdProductos.Col = 2
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTCodigo = grdProductos.CtlText
                                    grdProductos.Col = 4
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTProducto = grdProductos.CtlText
                                    grdProductos.Col = 6
                                    grdProductos.Row = grdProductos.Rows - 1
                                    VTMoneda = grdProductos.CtlText
                                Else
                                    PMChequea(sqlconn)
                                End If
							End While
							grdProductos.Row = 1
						End If
				End Select
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
		grdProductos_DoubleClick(grdProductos, New EventArgs())
	End Sub

	Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1327))
	End Sub

	Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        ReDim VGProductos(1)
		cmdEscoger.Enabled = False
		Me.Close()
	End Sub

	Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1698))
	End Sub

	Private Sub FAyudaProdFinal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1033))
        cmdBuscar_Click(cmdBuscar(0), New EventArgs())
        PLTSEstado()
	End Sub

	Private Sub FAyudaProdFinal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 0
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
    End Sub

	Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
		Dim VTRow As Integer = grdProductos.Row
		grdProductos.Row = 1
		grdProductos.Col = 1
		If grdProductos.CtlText <> "" Then
			grdProductos.Row = VTRow
			PMMarcarProducto()
		End If
	End Sub

	Private Sub grdProductos_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdProductos.KeyUp
        grdProductos.Col = 0
		grdProductos.SelStartCol = 1
		grdProductos.SelEndCol = grdProductos.Cols - 1
		If grdProductos.Row = 0 Then
			grdProductos.SelStartRow = 1
			grdProductos.SelEndRow = 1
		Else
			grdProductos.SelStartRow = grdProductos.Row
			grdProductos.SelEndRow = grdProductos.Row
		End If
	End Sub

	Private Sub PMMarcarProducto()
		Dim VTCols As Integer = grdProductos.Cols - 1
        ReDim VGProductos(VTCols)
        VGProductos(0) = "P"
		For i As Integer = 1 To grdProductos.Cols - 1
			grdProductos.Col = i
            VGProductos(i) = grdProductos.CtlText
		Next i
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
		Me.Close()
    End Sub
    Private Sub PLTSEstado()
        TSBEscoger.Enabled = cmdEscoger.Enabled
        TSBEscoger.Visible = cmdEscoger.Visible
        TSBSalir.Enabled = cmdSalir.Enabled
        TSBSalir.Visible = cmdSalir.Visible
        TSBBuscar.Enabled = _cmdBuscar_0.Enabled
        TSBBuscar.Visible = _cmdBuscar_0.Visible
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

End Class


