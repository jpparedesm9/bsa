Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran090Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VTNiveles() As String

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTTransaccion As String = String.Empty
        Dim VTNivelAnt As String = String.Empty
        Dim VTGrupo As String = String.Empty
        Dim VTVez As Integer = 0
        Dim VTR As Integer = 0
        Dim VTNumOfRow As Integer = 0
        Dim VTN As Integer = 0
        Dim VTDentro As Integer = 0
        Dim VTNivel As Integer = 0
        Dim VTNomGrupo As String = ""
        Dim VTNiv As Integer = 0
        Dim VTNRow As Integer = 0
        Dim VTTotal As Integer = 0
        Dim VLTotal As Integer = 0
        Dim VTIniciaGrupo As Integer = 0
        Dim VTTran As String = ""
        Dim VTRow As Integer = 0
        Dim VTSigno As Integer = 0
        Select Case Index
            Case 0
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(508537), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(508540), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500420), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If

                'TBA 02/Jul/2016 columnas que no se presentan se configuran con visible false
                If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = False
                If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = False
                '
                txtCampo_Leave(txtCampo(1), New EventArgs())

                VTNivelAnt = "0"
                VTGrupo = "0"
                VTVez = 1
                VTR = 3
                VTNumOfRow = 0
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "90")
                PMPasoValores(sqlconn, "@i_caj", 0, SQLVARCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_tran", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT1, VTGrupo)
                PMPasoValores(sqlconn, "@i_rol", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "N")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_tot_caj_adm", True, FMLoadResString(508840)) Then
                    ReDim VTNiveles(10)
                    VTN = FMMapeaArreglo(sqlconn, VTNiveles)
                    For n As Integer = 1 To VTN
                        VTGrupo = "0"
                        VTR = 3
                        Do While VTR = 3
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "90")
                            PMPasoValores(sqlconn, "@i_caj", 0, SQLVARCHAR, txtCampo(0).Text)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(1).Text)
                            PMPasoValores(sqlconn, "@i_tran", 0, SQLINT1, "0")
                            PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT1, VTGrupo)
                            PMPasoValores(sqlconn, "@i_nivel", 0, SQLINT1, VTNiveles(n))
                            PMPasoValores(sqlconn, "@i_rol", 0, SQLINT2, txtCampo(2).Text)
                            If VTVez = 1 Then
                                PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "P")
                            Else
                                PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "G")
                            End If
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_tot_caj_adm", True, FMLoadResString(508840)) Then
                                VTDentro = 1
                                Dim VTArreglo(5) As String
                                VTR = FMMapeaArreglo(sqlconn, VTArreglo)
                                If VTR = 0 Then Exit Do
                                If VTVez = 1 Then
                                    PMMapeaGrid(sqlconn, grdRegistros, False)
                                    VTNumOfRow = 2
                                End If
                                VTNivel = CInt(VTArreglo(1))
                                VTGrupo = VTArreglo(2)
                                VTNomGrupo = VTArreglo(3)
                                PMChequea(sqlconn)
                                If VTVez = 1 Then
                                    For j As Integer = 1 To 12
                                        grdRegistros.Row = 1
                                        grdRegistros.Col = j
                                        If j = 2 Then
                                            VTNiv = grdRegistros.Row
                                            grdRegistros.CtlText = CStr(CDbl(FMLoadResString(509115) + "  ") + VTNivel) 'TRANSACCIONES NIVEL
                                            grdRegistros.Rows += 2
                                            grdRegistros.Row = 3
                                            grdRegistros.CtlText = FMLoadResString(509113) + "  ''" & VTNomGrupo & "''" 'GRUPO DE TRANSACCIONES
                                            grdRegistros.ColWidth(CShort(j)) = 4000
                                            grdRegistros.Row = 1
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
                                    If StringsHelper.ToDoubleSafe(VTNivelAnt) <> VTNivel Then
                                        VTNivelAnt = VTNiveles(n)
                                        grdRegistros.Col = 2
                                        grdRegistros.Rows += 5
                                        grdRegistros.Row = grdRegistros.Rows - 3
                                        VTNiv = grdRegistros.Row
                                        grdRegistros.CtlText = CStr(CDbl(FMLoadResString(509115) + "  ") + VTNivel) 'TRANSACCIONES NIVEL
                                        grdRegistros.Row += 2
                                        grdRegistros.CtlText = FMLoadResString(509113) + "  ''" & VTNomGrupo & "''" 'GRUPO DE TRANSACCIONES
                                    Else
                                        grdRegistros.Rows += 3
                                        grdRegistros.Row = grdRegistros.Rows - 1
                                        grdRegistros.Col = 2
                                        grdRegistros.CtlText = FMLoadResString(509113) + "  ''" & VTNomGrupo & "''" 'GRUPO DE TRANSACCIONES
                                        grdRegistros.Row = grdRegistros.Rows - 3
                                        VTNRow = grdRegistros.Row - 1
                                        grdRegistros.Col = 2
                                        grdRegistros.CtlText = FMLoadResString(509114) 'TOTALES DEL GRUPO
                                        For k As Integer = 3 To 12
                                            grdRegistros.Col = k
                                            VTTotal = 0
                                            For j As Integer = VTNumOfRow To VTNRow
                                                grdRegistros.Row = j
                                                If grdRegistros.CtlText <> "" Then
                                                    grdRegistros.Col = 1
                                                    If grdRegistros.CtlText <> "" Then
                                                        VTTransaccion = grdRegistros.CtlText
                                                    Else
                                                        VTTransaccion = "0"
                                                    End If
                                                    If CDbl(VTTransaccion) = 26200 Then
                                                        grdRegistros.Col = k
                                                        VTTotal += CDec(grdRegistros.CtlText)
                                                    Else
                                                        If CDbl(VTTransaccion) = 26201 Then
                                                            grdRegistros.Col = k
                                                            VTTotal -= CDec(grdRegistros.CtlText)
                                                        Else
                                                            grdRegistros.Col = k
                                                            VTTotal += CDec(grdRegistros.CtlText)
                                                        End If
                                                    End If
                                                End If
                                            Next j
                                            grdRegistros.Row = VTNRow + 1
                                            If k = 3 Then
                                                grdRegistros.CtlText = Conversion.Str(VTTotal)
                                            Else
                                                grdRegistros.CtlText = StringsHelper.Format(Conversion.Str(VTTotal), "#,##0.00")
                                            End If
                                        Next k
                                    End If
                                    VTNumOfRow = grdRegistros.Rows
                                End If
                                VTIniciaGrupo = True
                                While VTDentro <> 0
                                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "90")
                                    PMPasoValores(sqlconn, "@i_caj", 0, SQLVARCHAR, txtCampo(0).Text)
                                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(1).Text)
                                    If VTIniciaGrupo Then
                                        PMPasoValores(sqlconn, "@i_tran", 0, SQLINT2, "0")
                                    Else
                                        PMPasoValores(sqlconn, "@i_tran", 0, SQLINT2, VTTran)
                                    End If
                                    PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT1, VTGrupo)
                                    PMPasoValores(sqlconn, "@i_nivel", 0, SQLINT1, VTNiveles(n))
                                    PMPasoValores(sqlconn, "@i_rol", 0, SQLINT2, txtCampo(2).Text)
                                    PMPasoValores(sqlconn, "@i_proc", 0, SQLCHAR, "T")
                                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_tot_caj_adm", True, FMLoadResString(508840)) Then
                                        PMMapeaGrid(sqlconn, grdRegistros, True)
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
                                txtCampo(1).Focus()
                                PMLimpiaGrid(grdRegistros)
                                Exit Sub
                            End If
                        Loop
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
                            For j As Integer = VTNiv To grdRegistros.Rows - 3
                                grdRegistros.Row = j
                                grdRegistros.Col = k
                                If grdRegistros.CtlText <> "" Then
                                    grdRegistros.Col = 2
                                    If grdRegistros.CtlText <> FMLoadResString(509114) And grdRegistros.CtlText.Trim <> FMLoadResString(508720) Then 'TOTALES DEL GRUPO, TOTALES
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
                        VTNivelAnt = CStr(VTNivel)
                    Next n
                    'TBA Se agrega validación para controlar cuando las columnas existen
                    If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = False
                    If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = False
                    If grdRegistros.Cols > 9 Then grdRegistros.ColIsVisible(9) = False
                    If grdRegistros.Cols > 10 Then grdRegistros.ColIsVisible(10) = False
                    If grdRegistros.Cols > 11 Then grdRegistros.ColIsVisible(11) = False
                    If grdRegistros.Cols > 13 Then grdRegistros.ColIsVisible(13) = False
                    For i As Integer = 3 To 12
                        If i < grdRegistros.Cols Then
                            grdRegistros.ColAlignment(CShort(i)) = 1
                        End If
                    Next i
                    cmdBoton(3).Enabled = True
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                txtCampo(0).Text = VGLogin
                txtCampo(1).Text = ""
                txtCampo(2).Text = ""
                lblDescripcion(0).Text = ""

                'TBA 02/Jul/2016 Se configura en visible true para que el evento limpiar no genere error
                If grdRegistros.Cols > 0 Then grdRegistros.ColIsVisible(0) = True
                If grdRegistros.Cols > 1 Then grdRegistros.ColIsVisible(1) = True
                PMLimpiaGrid(grdRegistros)
                txtCampo(1).Focus()
                cmdBoton(3).Enabled = False
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
        End Select
    End Sub

    Private Sub FTran090_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        txtCampo(0).Text = VGLogin
        PLTSEstado()
    End Sub

    Private Sub FTran090_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1200
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 24
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGBanco)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 16
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(501129) + " ") 'Rol
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1200
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        Dim VLRol As String = txtCampo(2).Text
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VLRol)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4800
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(500348) + " ") 'Fecha:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5400
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGFecha)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6300
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509102) + " ") 'Hora:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6800
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(DateTime.Now.ToString("HH:mm:ss"))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7500
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509104)) 'Terminal:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8300
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGTerminal)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9200
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(500366)) 'Usuario:
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9900
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2100
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VGLogin)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 2500
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 16
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509103) + "  ''" & txtCampo(0).Text & " ''  " & FMLoadResString(503203) + "  ''" & lblDescripcion(0).Text & "''") 'TOTALES DEL CAJERO
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 6
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 2585
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(502944)) 'Efectivo
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 3158
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(2215)) 'No.
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 4566
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509106)) 'Chq. Propios
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5983
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509107)) 'Chq. Locales
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7401
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509108)) 'Chq. Plazas
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8810
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, FMLoadResString(509109)) 'Otros Valores
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10236
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509110)) 'Totales
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(38), New String("_", 150))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
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
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VTLin = 108 Then
                VTLin = 1
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 800
            End If
            VTLin += 1
        Next i
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7000
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("_", 50))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7000
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509112))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Index = 1 Then
            VLPaso = False
        End If
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508657))
            Case 1
                VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502500))
            Case 2
                VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508515))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode        
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            If Index = 1 Then
                VGOperacion = "sp_oficina"
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502503) & txtCampo(0).Text & "]") Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(1).Text = VGACatalogo.Codigo
                    lblDescripcion(0).Text = VGACatalogo.Descripcion
                Else
                    PMChequea(sqlconn)
                End If
                VLPaso = True
            End If
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii <> 45) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 95) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                End If
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToLower())
            Case 1, 2
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Index = 1 Then
            If Not VLPaso Then
                If txtCampo(1).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtCampo(0).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        VLPaso = True
                        txtCampo(1).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(1).Focus()
                        PMLimpiaGrid(grdRegistros)
                    End If
                Else
                    lblDescripcion(0).Text = ""
                End If
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


