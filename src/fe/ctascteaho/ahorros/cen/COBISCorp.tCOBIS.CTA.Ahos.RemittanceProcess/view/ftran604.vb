Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FTran604Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLFormatoFecha As String = ""
	Dim VLPAG As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_3.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				PLSiguiente()
			Case 2
				PLImprimir()
			Case 3
				Me.Close()
		End Select
	End Sub

	Private Sub FTran604_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = _cmdBoton_0.Enabled
        TSBSiguientes.Visible = _cmdBoton_0.Visible
        TSBImprimir.Enabled = _cmdBoton_2.Enabled
        TSBImprimir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub


    Public Sub PLInicializar()
        VLFormatoFecha = VGFormatoFecha
        txtOficina.Text = VGOficina
        txtOficina_Leave(txtOficina, New EventArgs())
        lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        PLBuscar()
    End Sub

	Private Sub FTran604_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PLBuscar()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "606")
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
		PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        Dim VTFecha As String = FMConvFecha(lblDescripcion(1).Text, VLFormatoFecha, "mm/dd/yyyy")


        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_cons_chq_eofi", True, FMLoadResString(508835)) Then
            PMMapeaGrid(sqlconn, grdCheque, False)
            PMChequea(sqlconn)
            grdCheque.ColWidth(1) = 1200
            grdCheque.ColWidth(2) = 1200
            grdCheque.ColWidth(3) = 800
            grdCheque.ColWidth(4) = 1800
            grdCheque.ColWidth(5) = 1200
            grdCheque.ColWidth(6) = 1500
            grdCheque.ColWidth(7) = 1200
            grdCheque.ColWidth(8) = 1500
            grdCheque.ColWidth(9) = 1500
            grdCheque.ColWidth(10) = 800
            grdCheque.ColWidth(11) = 800
            If Conversion.Val(Convert.ToString(grdCheque.Tag)) >= 20 Then
                PLSiguiente()
            Else
                If grdCheque.Rows - 1 >= 1 Then cmdBoton(2).Enabled = True
            End If
            If grdCheque.Rows > 0 Then
                For i As Integer = 1 To grdCheque.Rows - 1
                    grdCheque.Row = i
                    grdCheque.Col = 1
                    If grdCheque.CtlText.Trim() <> "" Then
                        grdCheque.Col = 0
                        grdCheque.CtlText = CStr(grdCheque.Row)
                    End If
                Next i
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
	End Sub

	Private Sub PLImprimir()
		Try 
            'Const IDYES As Integer = 6
			Dim archivos As String = string.Empty
			Dim  VTMsg As String = string.Empty
			Dim VTR As DialogResult
			Dim reportes As String = ""
			Dim BaseDatos As DAO.Database
			Dim tablas1, tablas2 As DAO.Recordset
			If grdCheque.Rows > 1 Then
				Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
				archivos = VGPath & "\REMESAS.MDB"
				BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivos)
				tablas1 = BaseDatos.OpenRecordset("re_encabezado")
				tablas2 = BaseDatos.OpenRecordset("re_detalle")
				BaseDatos.Execute("delete from re_detalle")
				BaseDatos.Execute("delete from re_encabezado")
				tablas1.AddNew()
				tablas1.Fields("en_oficina").Value = CInt(VGOficina)
				tablas1.Fields("en_desc_oficina").Value = txtOficina.Text & "  " & lblDescripcion(0).Text
				tablas1.Fields("en_fecha").Value = lblDescripcion(1).Text
				tablas1.Update()
				tablas1.Close()
				For i As Integer = 1 To (grdCheque.Rows - 1)
					grdCheque.Row = i
					tablas2.AddNew()
					tablas2.Fields("de_oficina").Value = CInt(VGOficina)
					grdCheque.Col = 1
					tablas2.Fields("de_cta_deposito").Value = grdCheque.CtlText
					grdCheque.Col = 2
					tablas2.Fields("de_cta_girada").Value = grdCheque.CtlText
					grdCheque.Col = 3
					tablas2.Fields("de_num_cheque").Value = grdCheque.CtlText
					grdCheque.Col = 4
					tablas2.Fields("de_valor").Value = grdCheque.CtlText
					grdCheque.Col = 5
					tablas2.Fields("de_num_bco_girado").Value = grdCheque.CtlText
					grdCheque.Col = 6
					tablas2.Fields("de_desc_banco").Value = grdCheque.CtlText
					grdCheque.Col = 7
					tablas2.Fields("de_ciudad_girada").Value = grdCheque.CtlText
					grdCheque.Col = 8
					tablas2.Fields("de_desc_ciudad").Value = grdCheque.CtlText
					grdCheque.Col = 9
					tablas2.Fields("de_departamento").Value = grdCheque.CtlText
					grdCheque.Col = 10
					tablas2.Fields("de_num_carta").Value = grdCheque.CtlText
					grdCheque.Col = 11
					tablas2.Fields("de_num_remesa").Value = grdCheque.CtlText
					tablas2.Update()
				Next i
				tablas2.Close()
				VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
				VTR = COBISMsgBox.MsgBox(VTMsg, 36, "Control de impresión de Datos.")
				If VTR = System.Windows.Forms.DialogResult.Yes Then
					reportes = VGPath & "\rel_chq_via_bcos.rpt"
					rptReporte.ReportFileName = reportes
					rptReporte.CopiesToPrinter = 1
					rptReporte.DataFiles(0) = archivos
					rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToPrinter
					rptReporte.Action = 1
				End If
				Me.Cursor = System.Windows.Forms.Cursors.Default
				BaseDatos.Close()
			Else
                COBISMessageBox.Show(FMLoadResString(500426), FMLoadResString(500427), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
				Me.Cursor = System.Windows.Forms.Cursors.Default
			End If
		Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(500428) & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Me.Cursor = System.Windows.Forms.Cursors.Default
			Exit Sub
		End Try
	End Sub

	Private Sub PLSiguiente()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "606")
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
		PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
		Dim VTFecha As String = FMConvFecha(lblDescripcion(1).Text, VLFormatoFecha, "mm/dd/yyyy")
		PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
		grdCheque.Row = grdCheque.Rows - 1
		grdCheque.Col = 10
		PMPasoValores(sqlconn, "@i_carta", 0, SQLINT4, grdCheque.CtlText)
		grdCheque.Col = 11
		PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdCheque.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_cons_chq_eofi", True, FMLoadResString(508835)) Then
            PMMapeaGrid(sqlconn, grdCheque, True)
            PMChequea(sqlconn)
            grdCheque.ColWidth(1) = 1200
            grdCheque.ColWidth(2) = 1200
            grdCheque.ColWidth(3) = 800
            grdCheque.ColWidth(4) = 1800
            grdCheque.ColWidth(5) = 1200
            grdCheque.ColWidth(6) = 1500
            grdCheque.ColWidth(7) = 1200
            grdCheque.ColWidth(8) = 1500
            grdCheque.ColWidth(9) = 1500
            grdCheque.ColWidth(10) = 800
            grdCheque.ColWidth(11) = 800
            If Conversion.Val(Convert.ToString(grdCheque.Tag)) >= 20 Then
                PLSiguiente()
            Else
                If grdCheque.Rows - 1 > 1 Then
                    cmdBoton(2).Enabled = True
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
	End Sub

	Private Sub txtOficina_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.Leave
		If txtOficina.Text <> "" Then
			PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
			PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtOficina.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficina.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblDescripcion(0))
                PMChequea(sqlconn)
            Else                
                PMChequea(sqlconn)
                txtOficina.Text = ""
                lblDescripcion(0).Text = ""
                COBISMessageBox.Show(FMLoadResString(508535), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
		Else
			lblDescripcion(0).Text = ""
		End If
	End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


