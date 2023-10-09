Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran080Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTGrupo As String = ""
        Dim VTVez As Integer = 0
        Dim VTNumOfRow As Integer = 0
        Dim VTDentro As Integer = 0
        Dim VTNomGrupo As String = ""
        Dim VTNRow As Integer = 0
        Dim VTTotal As Integer = 0
        Dim VLTotal As Integer = 0
        Dim VTIniciaGrupo As Integer = 0
        Dim VTTran As String = ""
        Dim VTRow As Integer = 0
        Dim VTSigno As Integer = 0
        Select Case Index
            Case 0
                txtCampo_Leave(txtCampo, New EventArgs())
                'TBA 01/Jul/2016 columnas que no se presentan se configuran con visible false
                If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = False
                If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = False

                If txtCampo.Text <> "" Then
                    VTGrupo = "0"
                    VTVez = 1
                    VTNumOfRow = 0

                    If VGNumGCtaCte = 0 Then
                        Exit Sub
                    End If

                    For i As Integer = 1 To VGNumGCtaCte
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "80")
                        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo.Text)
                        PMPasoValores(sqlconn, "@i_tran", 0, SQLINT1, "0")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT1, VTGrupo)
                        If VTVez = 1 Then
                            PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "P")
                        Else
                            PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "G")
                        End If
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_cons_tot_ofi_adm", True, FMLoadResString(508839)) Then
                            VTDentro = 1
                            Dim VTArreglo(5) As String
                            FMMapeaArreglo(sqlconn, VTArreglo)
                            If VTVez = 1 Then
                                PMMapeaGrid(sqlconn, grdRegistros, False)
                                PMAnchoColumnasGrid(grdRegistros)
                                VTNumOfRow = 2
                            End If
                            VTGrupo = VTArreglo(1)
                            VTNomGrupo = VTArreglo(2)
                            PMChequea(sqlconn)
                            If VTVez = 1 Then
                                For j As Integer = 1 To 12
                                    grdRegistros.Row = 1
                                    grdRegistros.Col = j
                                    If j = 2 Then
                                        grdRegistros.CtlText = FMLoadResString(509113) + "  ''" & VTNomGrupo & "''" 'GRUPO DE TRANSACCIONES
                                        grdRegistros.ColWidth(CShort(j)) = 4000
                                    Else
                                        grdRegistros.CtlText = ""
                                    End If
                                    If j = 1 Then
                                        grdRegistros.ColWidth(CShort(j)) = 400
                                    End If
                                    If j >= 4 Then
                                        grdRegistros.ColWidth(CShort(j)) = 1400
                                    End If
                                Next j
                                grdRegistros.ColWidth(13) = 1
                            Else
                                grdRegistros.Rows += 3
                                grdRegistros.Row = grdRegistros.Rows - 1
                                grdRegistros.Col = 2
                                grdRegistros.CtlText = FMLoadResString(509113) + "  ''" & VTNomGrupo & "''" 'GRUPO DE TRANSACCIONES
                                grdRegistros.Row = grdRegistros.Rows - 3
                                VTNRow = grdRegistros.Row - 1
                                grdRegistros.Col = 2
                                grdRegistros.CtlText = "TOTALES DEL GRUPO"
                                For k As Integer = 3 To 12
                                    grdRegistros.Col = k
                                    VTTotal = 0
                                    For j As Integer = VTNumOfRow To VTNRow
                                        grdRegistros.Row = j
                                        If grdRegistros.CtlText <> "" Then
                                            VTTotal += CDec(grdRegistros.CtlText)
                                        End If
                                    Next j
                                    grdRegistros.Row = VTNRow + 1
                                    If k = 3 Then
                                        grdRegistros.CtlText = Conversion.Str(VTTotal)
                                    Else
                                        grdRegistros.CtlText = StringsHelper.Format(Conversion.Str(VTTotal), "#,##0.00")
                                    End If
                                Next k
                                VTNumOfRow = grdRegistros.Rows
                            End If
                            VTIniciaGrupo = True
                            While VTDentro <> 0
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "80")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo.Text)
                                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                                PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT1, VTGrupo)
                                PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "T")
                                If VTIniciaGrupo Then
                                    PMPasoValores(sqlconn, "@i_tran", 0, SQLINT1, "0")
                                Else
                                    PMPasoValores(sqlconn, "@i_tran", 0, SQLINT1, VTTran)
                                End If
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_cons_tot_ofi_adm", True, FMLoadResString(508839)) Then
                                    PMMapeaGrid(sqlconn, grdRegistros, True)
                                    PMAnchoColumnasGrid(grdRegistros)
                                    PMChequea(sqlconn)
                                    VTIniciaGrupo = False
                                    VTVez += 1
                                    VTDentro = CInt(Convert.ToString(grdRegistros.Tag))
                                    VTRow = grdRegistros.Rows - 1
                                    grdRegistros.Col = 1
                                    grdRegistros.Row = VTRow
                                    VTTran = grdRegistros.CtlText
                                    If VTDentro < 20 Then
                                        VTDentro = 0
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    VTDentro = 0
                                End If
                            End While
                        Else
                            PMChequea(sqlconn)
                            txtCampo.Focus()
                            PMLimpiaGrid(grdRegistros)
                            Exit Sub
                        End If
                    Next i
                    grdRegistros.Rows += 1
                    grdRegistros.Row = grdRegistros.Rows - 1
                    VTNRow = grdRegistros.Row - 1
                    grdRegistros.Col = 2
                    grdRegistros.CtlText = FMLoadResString(509114) 'TOTALES DEL GRUPO
                    For k As Integer = 3 To 12
                        grdRegistros.Col = k
                        VTTotal = 0
                        For j As Integer = VTNumOfRow To VTNRow
                            grdRegistros.Row = j
                            If grdRegistros.CtlText <> "" Then
                                VTTotal += CDec(grdRegistros.CtlText)
                            End If
                        Next j
                        grdRegistros.Row = VTNRow + 1
                        If k = 3 Then
                            grdRegistros.CtlText = Conversion.Str(VTTotal)
                        Else
                            grdRegistros.CtlText = StringsHelper.Format(Conversion.Str(VTTotal), "#,##0.00")
                        End If
                    Next k
                    grdRegistros.Rows += 2
                    grdRegistros.Row = grdRegistros.Rows - 1
                    grdRegistros.Col = 2
                    grdRegistros.CtlText = "     " + FMLoadResString(508720) 'TOTALES
                    For k As Integer = 3 To 12
                        VLTotal = 0
                        grdRegistros.Col = k
                        For j As Integer = 1 To grdRegistros.Rows - 3
                            grdRegistros.Row = j
                            grdRegistros.Col = k
                            If grdRegistros.CtlText <> "" Then
                                grdRegistros.Col = 2
                                If grdRegistros.CtlText <> FMLoadResString(509114) Then 'TOTALES DEL GRUPO
                                    grdRegistros.Col = 13
                                    VTSigno = 0
                                    If grdRegistros.CtlText.ToUpper().StartsWith("S") Then
                                        Select Case Strings.Right(grdRegistros.CtlText, 1)
                                            Case "+"
                                                VTSigno = 1
                                            Case "-"
                                                VTSigno = -1
                                        End Select
                                    End If
                                    If k = 3 Then VTSigno = 1
                                    grdRegistros.Col = k
                                    VLTotal += VTSigno * CDec(grdRegistros.CtlText)
                                End If
                            End If
                        Next j
                        grdRegistros.Row = grdRegistros.Rows - 1
                        grdRegistros.Col = k
                        If k = 3 Then
                            grdRegistros.CtlText = Conversion.Str(VLTotal)
                        Else
                            grdRegistros.CtlText = StringsHelper.Format(Conversion.Str(VLTotal), "#,##0.00")
                        End If
                    Next k
                    For i As Integer = 3 To 12
                        'TBA Se agrega validación para controlar cuando las columnas existen
                        If i < grdRegistros.Cols Then
                            grdRegistros.ColAlignment(CShort(i)) = 1
                        Else
                            Exit For
                        End If
                    Next i

                    'TBA 01/Jul/2016 Se agrega validación para controlar cuando las columnas existen y configurar visible false las que no se pueden ver
                    If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = False
                    If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = False
                    If grdRegistros.Cols > 9 Then grdRegistros.ColIsVisible(9) = False
                    If grdRegistros.Cols > 10 Then grdRegistros.ColIsVisible(10) = False
                    If grdRegistros.Cols > 11 Then grdRegistros.ColIsVisible(11) = False

                    cmdBoton(3).Enabled = True
                    PLTSEstado()
                Else
                    COBISMessageBox.Show(FMLoadResString(508536), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo.Focus()
                End If
            Case 1
                txtCampo.Text = ""
                lblDescripcion(0).Text = ""

                'TBA 01/Jul/2016 Se configura en visible true para que el evento limpiar no genere error
                If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = True
                If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = True

                PMLimpiaGrid(grdRegistros)
                txtCampo.Focus()
                cmdBoton(3).Enabled = False
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
        End Select
    End Sub

    Private Sub FTran080_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FTran080_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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

    Private Sub PLImprimir()
        Dim VGTerminal As String = ""
        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1200
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 24
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGBanco)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(500348) + " ") 'Fecha:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4800
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGFecha)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5800
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509102) + " ") 'Hora:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6400
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(DateTime.Now.ToString("HH:mm:ss"))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7300
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509104) + " ") 'Terminal
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGTerminal)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(500366) + " ") 'Usuario
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9900
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGLogin)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 400
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2500
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 16
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509105) + " ''" & lblDescripcion(0).Text & "''") 'TOTALES DE CAJA DE LA OFICINA
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 6
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 2585
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(502594)) 'No.
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 3158
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(2215)) 'Efectivo
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4566
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509106)) 'Chq. Propios
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5983
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509107)) 'Chq. Locales
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7401
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509108)) 'Chq. Plazas
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8810
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509109)) 'Otros Valores
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10236
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509110)) 'Totales
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 11200
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509111))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(40), New String("_", 150))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        Dim VTLin As Integer = 20
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = i
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.SPC(1))
            grdRegistros.Col = 2
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 2585
            grdRegistros.Col = 3
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 3158
            grdRegistros.Col = 4
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4566
            grdRegistros.Col = 5
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5983
            grdRegistros.Col = 6
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7401
            grdRegistros.Col = 7
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8810
            grdRegistros.Col = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10236
            grdRegistros.Col = 12
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 11200
            grdRegistros.Col = 13
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VTLin = 105 Then
                VTLin = 1
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 800
            End If
            VTLin += 1
        Next i
        If (VTLin + 10) > 110 Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1200
        End If
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7000
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("_", 50))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7000
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509112)) 'Firma de Responsabilidad
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502500))
        txtCampo.SelectionStart = 0
        txtCampo.SelectionLength = Strings.Len(txtCampo.Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCampo.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode        
        If Keycode = VGTeclaAyuda Then
            VGOperacion = "sp_oficina"
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtCampo.Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo.Text = VGACatalogo.Codigo
                lblDescripcion(0).Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
            End If
            VLPaso = True
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCampo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Leave
        If Not VLPaso Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502657) & txtCampo.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblDescripcion(0))
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                VLPaso = True
                txtCampo.Text = ""
                lblDescripcion(0).Text = ""
                txtCampo.Focus()
                PMLimpiaGrid(grdRegistros)
            End If
        End If
    End Sub
    Private Sub PLTSEstado()
        TSBImprimir.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_3.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
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
End Class


