Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Partial Public Class FConsultaCtaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLTipo As String = ""
    Dim VLMoneda As String = ""
    Dim VLCol As Integer = 0
    Dim VLRow As Integer = 0
    Dim VLPaso As Integer = 0
    Dim VLLongitud As Integer = 0
    Dim VLPosDeci As Integer = 0
    Private colDesc As Integer = 0, colServicio As Integer, colDesde As Integer, colTipoRango As Integer
    Private colHasta As Integer, colGrupo As Integer, colCosto As Integer, colRango As Integer
    Private colTipoDato As Integer, colCostoMinimo As Integer, colCostoMaximo As Integer

    Public FPersoCuenta As Object


    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFilas1 As Integer = 0
        Dim VTServicio1 As String = String.Empty
        Dim VTRango1 As String = String.Empty
        Dim VTFilas2 As Integer = 0
        Dim VTServicio2 As String = String.Empty
        Dim VTRango2 As String = String.Empty
        Dim VTMinValor As Decimal = 0
        Dim VTMaxValor As Decimal = 0
        Dim VTMedValor As Decimal = 0
        Dim VTMoP As String = ""
        Dim VTValor As Decimal = 0
        TSBotones.Focus()
        Select Case Index
            Case 0
                For i As Integer = 1 To grdServicios(1).Rows - 1
                    grdServicios(1).Row = i
                    grdServicios(1).Col = grdServicios(1).Cols - 3
                    If Strings.Len(grdServicios(1).CtlText) > 0 Then
                        If Not FMVerFormato(grdServicios(1).CtlText, VGFormatoFecha) Then
                            COBISMessageBox.Show(FMLoadResString(1379), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            grdServicios(1).CtlText = ""
                            Exit Sub
                        End If
                        If Not Information.IsDate(grdServicios(1).CtlText) Or FMDateDiff("d", CDate(grdServicios(1).CtlText).ToString("MM/dd/yyyy"), VGFecha, "mm/dd/yyyy") > 0 Then
                            COBISMessageBox.Show(FMLoadResString(1360), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            grdServicios(1).CtlText = ""
                            Exit Sub
                        End If
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                        If Strings.Len(grdServicios(1).CtlText) > 0 Then
                            'TBA 16/Ago/2016 Se agrega validación del costo mínimo y máximo
                            grdServicios(1).Col = colCostoMinimo ' 11
                            VTMinValor = CDbl(grdServicios(1).CtlText) 'Conversion.Val(grdServicios(1).CtlText)
                            grdServicios(1).Col = colCostoMaximo ' 12
                            VTMaxValor = CDbl(grdServicios(1).CtlText) 'Conversion.Val(grdServicios(1).CtlText)
                            grdServicios(1).Col = colCosto '7
                            VTMedValor = CDbl(grdServicios(1).CtlText)
                            grdServicios(1).Col = CShort(grdServicios(1).Cols - 2)
                            VTMoP = grdServicios(1).CtlText
                            '
                            grdServicios(1).Col = grdServicios(1).Cols - 1
                            If Strings.Len(grdServicios(1).CtlText) > 0 Then
                                If VTMoP = "M" Then
                                    VTValor = VTMedValor + CDbl(grdServicios(1).CtlText) '(Conversion.Val(grdServicios(1).CtlText))
                                ElseIf VTMoP = "P" Then
                                    VTValor = VTMedValor + VTMedValor * CDbl(grdServicios(1).CtlText) / 100 'Conversion.Val(grdServicios(1).CtlText) / 100
                                Else
                                    COBISMessageBox.Show(FMLoadResString(1171) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    grdServicios(1).Focus()
                                    Exit Sub
                                End If
                                VTValor = Math.Round(VTValor, 2)
                                If VTValor < VTMinValor Or VTValor > VTMaxValor Then
                                    COBISMessageBox.Show(FMLoadResString(2600) & " " & i & " " & FMLoadResString(2601), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    grdServicios(1).Focus()
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4068")
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "T")
                                PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, "C")
                                PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, "1")
                                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, lblDescripcion(4).Text)
                                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, VGCuenta)
                                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Text)
                                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text)
                                grdServicios(1).Col = 3
                                PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, grdServicios(1).CtlText)
                                grdServicios(1).Col = 5
                                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, grdServicios(1).CtlText)
                                grdServicios(1).Col = 7
                                PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, grdServicios(1).CtlText)
                                grdServicios(1).Col = 9
                                PMPasoValores(sqlconn, "@i_rango", 0, SQLINT4, grdServicios(1).CtlText)
                                grdServicios(1).Col = grdServicios(1).Cols - 3
                                PMPasoValores(sqlconn, "@i_fecha_venc", 0, SQLDATETIME, CDate(grdServicios(1).CtlText).ToString("MM/dd/yyyy"))
                                grdServicios(1).Col = grdServicios(1).Cols - 2
                                PMPasoValores(sqlconn, "@i_tipo_variacion", 0, SQLCHAR, grdServicios(1).CtlText)
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                PMPasoValores(sqlconn, "@i_valor_con", 0, SQLFLT8, grdServicios(1).CtlText)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1123)) Then
                                    PMChequea(sqlconn)
                                    VGPersonaliza = True
                                Else
                                    PMChequea(sqlconn)
                                    grdServicios(1).Col = 2
                                    COBISMessageBox.Show(FMLoadResString(1349) & (grdServicios(1).CtlText), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(1217) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                grdServicios(1).Focus()
                                Exit Sub
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(1171) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            grdServicios(1).Col = grdServicios(1).Cols - 2
                            grdServicios(1).Focus()
                            Exit Sub
                        End If
                        grdServicios(1).Col = grdServicios(1).Cols - 3
                        grdServicios(1).CtlText = ""
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                        grdServicios(1).CtlText = ""
                        grdServicios(1).Col = grdServicios(1).Cols - 1
                        grdServicios(1).CtlText = ""
                    Else
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                        If Strings.Len(grdServicios(1).CtlText) > 0 Then
                            grdServicios(1).Col = grdServicios(1).Cols - 1
                            If Strings.Len(grdServicios(1).CtlText) > 0 Then
                                COBISMessageBox.Show(FMLoadResString(1172) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                grdServicios(1).Col = grdServicios(1).Cols - 3
                                grdServicios(1).Focus()
                                Exit Sub
                            Else
                                COBISMessageBox.Show(FMLoadResString(1217) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                grdServicios(1).Focus()
                                Exit Sub
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(1171) & i, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            grdServicios(1).Col = grdServicios(1).Cols - 2
                            grdServicios(1).Focus()
                            Exit Sub
                        End If
                    End If
                Next i
            Case 1
                Me.Close()
            Case 2
                VTFilas1 = VGMaxRows
                VTServicio1 = "0"
                VTRango1 = "0"
                FPersoCuenta = Me.Owner()
                While VTFilas1 = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4070")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, VTServicio1)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango1)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Text)
                    PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, FPersoCuenta.txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, lblDescripcion(4).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, VGCuenta)
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(3).Text)
                    'PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1559)) Then
                        If VTServicio1 = "0" And VTRango1 = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios(0), False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios(0), True)
                        End If
                        PMMapeaTextoGrid(grdServicios(0))
                        PMAnchoColumnasGrid(grdServicios(0))
                        PMChequea(sqlconn)
                        grdServicios(0).Col = 1
                        grdServicios(0).Row = grdServicios(0).Rows - 1
                        VTServicio1 = grdServicios(0).CtlText
                        grdServicios(0).Col = 3
                        grdServicios(0).Row = grdServicios(0).Rows - 1
                        VTRango1 = grdServicios(0).CtlText
                        If Conversion.Val(Convert.ToString(grdServicios(0).Tag)) > 0 Then
                            grdServicios(0).ColAlignment(4) = 1
                            grdServicios(0).ColAlignment(5) = 1
                            grdServicios(0).ColAlignment(7) = 1
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas1 = Conversion.Val(Convert.ToString(grdServicios(0).Tag))
                End While

                grdServicios(0).Row = 1
                For VTi As Integer = 1 To grdServicios(0).Rows - 1
                    grdServicios(0).Row = VTi
                    For VTColumn As Integer = 1 To grdServicios(0).Cols - 1
                        grdServicios(0).Col = VTColumn
                        VLLongitud = 0
                        If VTColumn = 8 And grdServicios(0).CtlText <> "" Then
                            grdServicios(0).CtlText = CStr(FMConvFecha(grdServicios(0).CtlText, "mm/dd/yyyy", VGFormatoFecha))
                        End If

                        If grdServicios(0).CtlText <> "" And IsNumeric(grdServicios(0).CtlText) Then
                            VLLongitud = Len(grdServicios(0).CtlText)
                            If VLLongitud <> 1 Then
                                If InStr(grdServicios(0).CtlText, ".") Then
                                    VLPosDeci = InStr(grdServicios(0).CtlText, ".")
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdServicios(0).CtlText = grdServicios(0).CtlText + "0"
                                        VLPosDeci = 0
                                    End If
                                End If
                                If InStr(grdServicios(0).CtlText, ",") Then
                                    VLPosDeci = InStr(grdServicios(0).CtlText, ",")
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdServicios(0).CtlText = grdServicios(0).CtlText + "0"
                                        VLPosDeci = 0
                                    End If
                                End If
                               
                            End If
                        End If
                    Next VTColumn
                Next VTi

                grdServicios(0).Row = 1
                VTFilas2 = 20
                VTServicio2 = "0"
                VTRango2 = "0"
                While VTFilas2 = 20
                    Dim VLServicio As Integer = CInt(txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, VTServicio2)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango2)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, lblDescripcion(4).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Text)
                    PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, VLServicio)
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(3).Text)
                    ' PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1559)) Then
                        If VTServicio2 = "0" And VTRango2 = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios(1), False)
                            PMMapeaTextoGrid(grdServicios(1))
                            PMAnchoColumnasGrid(grdServicios(1))

                            If VLServicio > 0 Then
                                colDesc = 2 : colServicio = 3 : colDesde = 4 : colTipoRango = 5
                                colHasta = 6 : colGrupo = 7 : colCosto = 8 : colRango = 9
                                colTipoDato = 10 : colCostoMinimo = 11 : colCostoMaximo = 12
                            Else
                                colDesc = 1 : colServicio = 2 : colDesde = 3 : colTipoRango = 4
                                colHasta = 5 : colGrupo = 6 : colCosto = 7 : colRango = 8
                                colTipoDato = 9 : colCostoMinimo = 10 : colCostoMaximo = 11
                            End If

                            If Conversion.Val(Convert.ToString(grdServicios(1).Tag)) > 0 Then
                                grdServicios(1).Cols += 3
                                grdServicios(1).Row = 0
                                grdServicios(1).Col = grdServicios(1).Cols - 3
                                grdServicios(1).CtlText = UCase(FMLoadResString(1943))  'FECHA VENC
                                grdServicios(1).Col = grdServicios(1).Cols - 2
                                grdServicios(1).CtlText = FMLoadResString(1882)         'M / P
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                grdServicios(1).CtlText = UCase(FMLoadResString(1797))  'VALOR
                                grdServicios(1).ColWidth(CShort(grdServicios(1).Cols - 3)) = 1800
                                grdServicios(1).ColWidth(CShort(grdServicios(1).Cols - 2)) = 600
                                grdServicios(1).ColWidth(CShort(grdServicios(1).Cols - 1)) = 1800
                                cmdBoton(0).Enabled = True
                                cmdBoton(2).Enabled = True
                                PLTSEstado()

                            End If
                        Else
                            PMMapeaGrid(sqlconn, grdServicios(1), True)
                            PMMapeaTextoGrid(grdServicios(1))
                        End If
                        PMChequea(sqlconn)
                        VTFilas2 = Conversion.Val(Convert.ToString(grdServicios(1).Tag))
                        grdServicios(1).Col = 3
                        grdServicios(1).Row = grdServicios(1).Rows - 1
                        VTServicio2 = grdServicios(1).CtlText
                        grdServicios(1).Col = 9
                        grdServicios(1).Row = grdServicios(1).Rows - 1
                        VTRango2 = grdServicios(1).CtlText
                        If Conversion.Val(Convert.ToString(grdServicios(1).Tag)) > 0 Then
                            grdServicios(1).ColAlignment(7) = 1
                            grdServicios(1).ColAlignment(8) = 1
                            grdServicios(1).ColAlignment(9) = 1
                        End If

                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas2 = Conversion.Val(Convert.ToString(grdServicios(1).Tag))
                End While

                grdServicios(1).Row = 1
                For VTi As Integer = 1 To grdServicios(1).Rows - 1
                    grdServicios(1).Row = VTi
                    For VTColumn As Integer = 1 To grdServicios(1).Cols - 1
                        grdServicios(1).Col = VTColumn
                        VLLongitud = 0
                        If VTColumn = 1 And grdServicios(1).CtlText <> "" Then
                            grdServicios(1).CtlText = CStr(FMConvFecha(grdServicios(1).CtlText, "mm/dd/yyyy", VGFormatoFecha))
                        End If
                        If grdServicios(1).CtlText <> "" And IsNumeric(grdServicios(1).CtlText) Then
                            VLLongitud = Len(grdServicios(1).CtlText)
                            If VLLongitud <> 1 Then
                                If InStr(grdServicios(1).CtlText, ".") Then
                                    VLPosDeci = InStr(grdServicios(1).CtlText, ".")
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdServicios(1).CtlText = grdServicios(1).CtlText + "0"
                                        VLPosDeci = 0
                                    End If
                                End If
                                If InStr(grdServicios(1).CtlText, ",") Then
                                    VLPosDeci = InStr(grdServicios(1).CtlText, ",")
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdServicios(1).CtlText = grdServicios(1).CtlText + "0"
                                        VLPosDeci = 0
                                    End If
                                End If
                            End If
                        End If
                    Next VTColumn
                Next

                grdServicios(1).Row = 1
            Case 3
                txtCampo(1).Text = ""
                txtCampo(3).Text = ""
                lblDescripcion(6).Text = ""
                lblDescripcion(7).Text = ""
                cmdBoton(2).Enabled = False
                cmdBoton(0).Enabled = False
                grdServicios(0).Rows = 2
                grdServicios(0).Cols = 2
                grdServicios(0).Row = 0
                grdServicios(0).Col = 1
                grdServicios(0).CtlText = ""
                grdServicios(0).Row = 1
                grdServicios(0).Col = 0
                grdServicios(0).CtlText = ""
                grdServicios(0).Row = 1
                grdServicios(0).Col = 1
                grdServicios(0).CtlText = ""
                grdServicios(0).ColWidth(1) = grdServicios(0).ColWidth(0)
                grdServicios(1).Rows = 2
                grdServicios(1).Cols = 2
                grdServicios(1).Row = 0
                grdServicios(1).Col = 1
                grdServicios(1).CtlText = ""
                grdServicios(1).Row = 1
                grdServicios(1).Col = 0
                grdServicios(1).CtlText = ""
                grdServicios(1).Row = 1
                grdServicios(1).Col = 1
                grdServicios(1).CtlText = ""
                grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
                txtCampo(1).Enabled = True
                txtCampo(1).Focus()
                PLTSEstado()
        End Select
    End Sub


    Private Sub FConsultaCta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        Me.Text = FMLoadResString(1631)
        If lblDescripcion(1).Text <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, "") Then
                PMMapeaVariable(sqlconn, VLMoneda)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
            End If
        End If
        cmdBoton(0).Enabled = False
        cmdBoton(2).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FConsultaCta_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdServicios_ClickEvent(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.ClickEvent, _grdServicios_0.ClickEvent
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        If Index = 1 Then
            VLRow = grdServicios(1).Row
            VLCol = grdServicios(1).Col
        End If
        If Index = 1 And VLCol > 0 Then
            grdServicios(1).Col = VLCol
        End If

        Select Case Index
            'Case 0, 1
            Case 0
                'grdServicios(Index).Col = 0
                grdServicios(Index).SelStartCol = 1
                grdServicios(Index).SelEndCol = grdServicios(Index).Cols - 1
                If grdServicios(Index).Row = 0 Then
                    grdServicios(Index).SelStartRow = 1
                    grdServicios(Index).SelEndRow = 1
                Else
                    grdServicios(Index).SelStartRow = grdServicios(Index).Row
                    grdServicios(Index).SelEndRow = grdServicios(Index).Row
                End If
        End Select
    End Sub

    Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.Enter, _grdServicios_0.Enter
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1720))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1722))
        End Select
    End Sub

    Private Sub grdServicios_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyPressEvent) Handles _grdServicios_1.KeyPressEvent, _grdServicios_0.KeyPressEvent
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Dim VTRow As Integer = 0
        Dim VTCol As Integer = 0
        Dim VTDato As String = ""
        If Index = 1 Then

            VTRow = grdServicios(1).Row
            VTCol = grdServicios(1).Col
            If VTCol < 11 Then Exit Sub
            grdServicios(1).Row = 1
            grdServicios(1).Col = 1
            If grdServicios(1).CtlText = "" Then
                Exit Sub
            End If
            grdServicios(1).Row = VTRow
            grdServicios(1).Col = VTCol
            If grdServicios(1).Col = grdServicios(1).Cols - 3 Then
                If eventArgs.KeyAscii = 8 Then
                    If Strings.Len(grdServicios(1).CtlText) > 0 Then
                        grdServicios(1).CtlText = Strings.Mid(grdServicios(1).CtlText, 1, Strings.Len(grdServicios(1).CtlText) - 1)
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    End If
                End If
                If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And (Strings.Chr(eventArgs.KeyAscii).ToString()) <> "/" Then
                    eventArgs.KeyAscii = 0
                    VLRow = grdServicios(1).Row
                    VLCol = grdServicios(1).Col
                    grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                    Exit Sub
                Else
                    grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
                End If
            ElseIf grdServicios(1).Col = grdServicios(1).Cols - 2 Then
                If eventArgs.KeyAscii = 8 Then
                    If Strings.Len(grdServicios(1).CtlText) > 0 Then
                        grdServicios(1).CtlText = Strings.Mid(grdServicios(1).CtlText, 1, Strings.Len(grdServicios(1).CtlText) - 1)
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    End If
                End If
                If Strings.Len(grdServicios(1).CtlText) > 0 Then
                    eventArgs.KeyAscii = 0
                    Exit Sub
                End If
                If Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() = "P" Or Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() = "M" Then
                    eventArgs.KeyAscii = Strings.AscW(Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper())
                    grdServicios(1).CtlText = (Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper())
                    VLTipo = grdServicios(1).CtlText
                Else
                    eventArgs.KeyAscii = 0
                End If
            ElseIf grdServicios(1).Col = grdServicios(1).Cols - 1 Then
                VTCol = grdServicios(1).Col
                grdServicios(1).Col = grdServicios(1).Cols - 2
                VTDato = grdServicios(1).CtlText
                grdServicios(1).Col = VTCol
                If VLTipo = "" Then
                    eventArgs.KeyAscii = 0
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    VLRow = grdServicios(1).Row
                    VLCol = grdServicios(1).Col
                    grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                    Exit Sub
                End If
                If eventArgs.KeyAscii = 8 Then
                    If Strings.Len(grdServicios(1).CtlText) > 0 Then
                        grdServicios(1).CtlText = Strings.Mid(grdServicios(1).CtlText, 1, Strings.Len(grdServicios(1).CtlText) - 1)
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    End If
                End If
                If VLTipo = "P" Then
                    If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And (Strings.Chr(eventArgs.KeyAscii).ToString()) <> "." And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
                        eventArgs.KeyAscii = 0
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    Else
                        grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
                    End If
                Else
                    If VLMoneda = "N" And VLTipo = "M" And VTDato = "M" Then
                        If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
                            eventArgs.KeyAscii = 0
                            VLRow = grdServicios(1).Row
                            VLCol = grdServicios(1).Col
                            grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                            Exit Sub
                        Else
                            grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
                        End If
                    Else
                        If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And (Strings.Chr(eventArgs.KeyAscii).ToString()) <> "." And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
                            eventArgs.KeyAscii = 0
                            VLRow = grdServicios(1).Row
                            VLCol = grdServicios(1).Col
                            grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                            Exit Sub
                        Else
                            grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
                        End If
                    End If
                End If
                If Strings.Len(grdServicios(1).CtlText) > 0 And (grdServicios(1).CtlText <> "." And grdServicios(1).CtlText <> "+" And grdServicios(1).CtlText <> "-") Then
                    Dim dbNumericTemp As Double = 0
                    If Not Double.TryParse(grdServicios(1).CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Or ((grdServicios(1).CtlText.IndexOf("+"c) + 1) > 1) Or ((grdServicios(1).CtlText.IndexOf("-"c) + 1) > 1) Then
                        COBISMessageBox.Show(FMLoadResString(1804), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        grdServicios(1).CtlText = ""
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    End If
                End If
                If VLTipo = "P" Then
                    If Math.Abs(Conversion.Val(grdServicios(1).CtlText.ToString())) > 100 Then
                        COBISMessageBox.Show(FMLoadResString(1804), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        grdServicios(1).CtlText = ""
                        VLRow = grdServicios(1).Row
                        VLCol = grdServicios(1).Col
                        grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                        Exit Sub
                    End If
                End If
                If Strings.Len(grdServicios(1).CtlText) > 13 Then
                    COBISMessageBox.Show(FMLoadResString(1804), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    grdServicios(1).CtlText = ""
                    VLRow = grdServicios(1).Row
                    VLCol = grdServicios(1).Col
                    grdServicios_ClickEvent(grdServicios(1), New EventArgs())
                    Exit Sub
                End If
            End If
            VLCol = grdServicios(1).Col
            grdServicios_ClickEvent(grdServicios(1), New EventArgs())
        End If
    End Sub

    Private Sub grdServicios_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles _grdServicios_1.KeyUpEvent, _grdServicios_0.KeyUpEvent
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If isInitializingComponent Then
            Exit Sub
        End If
        If Index = 1 Then
            txtCampo(3).Text = ""
            lblDescripcion(6).Text = ""
            lblDescripcion(7).Text = ""
            PMLimpiaGrid(grdServicios(0))
            PMLimpiaGrid(grdServicios(1))
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1716))
        End Select
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Dim tempLoadForm As FCatalogoServClass = FCatalogoServ
            If Index = 1 Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1123)) Then
                    PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                    PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                    PMChequea(sqlconn)
                    VGOperacion = "operacionHCons"
                    FCatalogoServ.ShowPopup(Me)
                    VLPaso = True
                    If lblDescripcion(6).Text <> "" Then
                        cmdBoton(2).Enabled = True
                        cmdBoton(2).Focus()
                        txtCampo(1).Enabled = False
                        PLTSEstado()
                    Else
                        txtCampo(1).Text = ""
                    End If
                    FCatalogoServ.Dispose() '18/05/2016 migracion
                Else
                    PMChequea(sqlconn)
                End If
            End If
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If Not VLPaso Then
                    Dim tempLoadForm As FCatalogoServClass = FCatalogoServ
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "")
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                        PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1123)) Then
                            PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                            PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                            PMChequea(sqlconn)
                            VGOperacion = "operacionH2Cons"
                            If FCatalogoServ.grdRegistros.Rows > 1 Then
                                FCatalogoServ.ShowPopup(Me)
                                If lblDescripcion(6).Text <> "" Then
                                    cmdBoton(2).Enabled = True
                                    txtCampo(1).Enabled = False
                                    PLTSEstado()
                                Else
                                    txtCampo(1).Text = ""
                                End If
                                FCatalogoServ.Dispose() '18/05/2016 migracion
                            Else
                                COBISMessageBox.Show(FMLoadResString(1501), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(1).Text = ""
                                txtCampo(1).Focus()
                                Exit Sub
                            End If
                        Else
                            PMChequea(sqlconn)
                        End If
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_2.Enabled
        TSBBuscar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_1.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        txtCampo(0).Enabled = False
        txtCampo(2).Enabled = False
        '  PMObjetoSeguridad(cmdBoton(0))
        ' PMObjetoSeguridad(cmdBoton(2))
        '  PLTSEstado()
    End Sub

    Private Sub _grdServicios_1_RowColChange(sender As Object, e As EventArgs) Handles _grdServicios_1.RowColChange
        'VLRow = _grdServicios_1.Row
        'VLCol = _grdServicios_1.Col
        '_grdServicios_1.Row = 0
        'If VLCol > 0 Then
        '    _grdServicios_1.Col = VLCol
        'End If
    End Sub

End Class


