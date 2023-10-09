Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FImagenesClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTitularidad As String = ""
    Dim VLNomCta As String = ""
    Dim VLCedRuc As String = ""
    Dim VLClaseCta As String = ""
    Dim VLImagen As String = ""
    Dim VLSeguir As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLRefresca()
        End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Enter, _cmdBoton_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500015))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500224))
        End Select
    End Sub

    Private Sub FImagenes_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLRefresca()
        PLTSEstado()
    End Sub

    Private Sub FImagenes_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdImagen_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdImagen.DblClick

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim VTFirma As String = String.Empty
        Dim Codigo As String = "" 'JSA
        Dim Descrip As String = "" 'JSA
        If grdImagen.CtlText <> "" Then
            VTFirma = Strings.Mid(grdImagen.CtlText, 1, grdImagen.CtlText.IndexOf("-"c))
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "3020")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "E")
            PMPasoValores(sqlconn, "@i_imagen", 0, SQLINT4, VTFirma)
            FMLoadResString(2257)
            If FMTransmitirRPC(sqlconn, ServerName, "firmas", "sp_consulta_condiciones", True, " Ok ... Consulta de firmas y/o sellos") Then
                PMMapeaVariable(sqlconn, Codigo)
                PMMapeaVariable(sqlconn, Descrip)
                PMChequea(sqlconn)
                lblCodente.Text = Codigo
                lblnomente.Text = Descrip
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
        Else
            lblCodente.Text = ""
            lblnomente.Text = ""
        End If
    End Sub

    Private Sub grdImagen_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdImagen.Enter
        'KME COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" Firmas y Sellos de la Cuenta")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500225))
    End Sub

    Private Sub PLRefresca()
        Dim VTpos As Integer = 0
        grdImagen.Rows = 2
        grdImagen.Cols = 3
        If VGADatosI(2) = "AHO" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(1))
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
            PMPasoValores(sqlconn, "@o_titularidad", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " " & FMLoadResString(502522) & " ") Then
                PMMapeaVariable(sqlconn, VLTitularidad)
                PMChequea(sqlconn)
                VGTitularidad = FMRetParam(sqlconn, 1)
                Label1.Text = VGTitularidad
            Else
                PMChequea(sqlconn)
            End If
        Else
            If VGADatosI(2) = "CTE" Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(1))
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " " & FMLoadResString(502522) & " ") Then
                    PMMapeaVariable(sqlconn, VLNomCta)
                    PMMapeaVariable(sqlconn, VLCedRuc)
                    PMMapeaVariable(sqlconn, VLClaseCta)
                    PMMapeaVariable(sqlconn, VLTitularidad)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_titularidad")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, VLTitularidad)
                FMLoadResString(2257)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " " & FMLoadResString(502657) & " ") Then
                    PMMapeaObjeto(sqlconn, Label1)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            End If
        End If
        For i = 0 To grdImagen.Cols - 1
            grdImagen.Col = i
            grdImagen.ColWidth(CShort(i)) = 1
            For j As Integer = 0 To grdImagen.Rows - 1
                grdImagen.Row = j
                grdImagen.CtlText = ""
                'grdImagen.Picture = Image.FromFile("")
                grdImagen.Picture = Drawing.Image.FromFile("")
                'JSA grdImagen.RowHeight(CShort(j)) = 1
                grdImagen.RowHeightIndexed(CShort(j)) = 1
            Next j
        Next i
        Dim VTNoPaso As Integer = True
        Dim VTTipo As Boolean = True
        Dim VTFila As Integer = 1
        Dim VTcolumna As Integer = 0
        Dim VTFlag As Integer = True
        Dim VTIMAGEN As String = "0"
        Do While VTFlag
            VTpos = (VTIMAGEN.IndexOf("-"c) + 1)
            If VTpos <> 0 Then
                VLImagen = Strings.Mid(VTIMAGEN, 1, VTpos - 1).TrimEnd()
            Else
                VLImagen = VTIMAGEN.TrimEnd()
            End If
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "3016")
            PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, VGADatosI(1))
            PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, VGADatosI(2))
            PMPasoValores(sqlconn, "@i_imagen", 0, SQLINT4, VLImagen)
            PMPasoValores(sqlconn, "@i_interface", 0, SQLVARCHAR, "S")
            PMPasoValores(sqlconn, "@o_mas", 1, SQLINT2, "0")
            If FMTransmitirRPC(sqlconn, ServerName, "firmas", "sp_query_candidata", True, FMLoadResString(9930)) Then
                If VTIMAGEN = "0" Then
                    ReDim VGGrafo(100, 5)
                End If
                FMMapeaGrafo(sqlconn, VGGrafo, VTTipo)
                PMMapeaVariable(sqlconn, VLSeguir)
                PMChequea(sqlconn)
                If VLSeguir <> "0" Then
                    VTFlag = True
                    VTIMAGEN = VGGrafo(CInt(Conversion.Val(VGGrafo(0, 0))), 0)
                    VTTipo = False
                Else
                    VTFlag = False
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500226), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                PMChequea(sqlconn)
                VTFlag = False
                VTNoPaso = False
            End If
        Loop
        lbltotalfirmas.Text = CStr(0)
        If VTNoPaso Then
            If Conversion.Val(VGGrafo(0, 0)) >= 1 Then
                For i = 1 To Conversion.Val(VGGrafo(0, 0))
                    VTcolumna += 1
                    grdImagen.SelStartRow = VTFila
                    grdImagen.SelStartCol = VTcolumna
                    grdImagen.SelEndRow = VTFila
                    grdImagen.SelEndCol = VTcolumna
                    BitMap(grdImagen, VGGrafo(i, 1), VTcolumna, VTFila)
                    grdImagen.Col = VTcolumna
                    grdImagen.Row = VTFila
                    grdImagen.CtlText = VGGrafo(i, 0)
                    grdImagen.RowHeight = (CShort(VTFila)) = 2200
                    grdImagen.ColWidth(CShort(VTcolumna)) = 6000
                    grdImagen.ColAlignment(CShort(VTcolumna)) = 0
                    If (VTcolumna = 2) And (i < Conversion.Val(VGGrafo(0, 0))) Then
                        VTcolumna = 0
                        VTFila += 1
                        grdImagen.AddItem("" & Strings.Chr(9).ToString() & "" & Strings.Chr(9).ToString())
                    End If
                Next i
                lbltotalfirmas.Text = CStr(i - 1)
            End If
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBRefrescar.Enabled = _cmdBoton_1.Enabled
        TSBRefrescar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
    End Sub

    Private Sub TSBRefrescar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBRefrescar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

End Class


