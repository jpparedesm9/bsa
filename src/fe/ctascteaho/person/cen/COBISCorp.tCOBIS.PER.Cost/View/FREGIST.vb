Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Partial Public Class FRegistrosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        Select Case VGOperacion
            Case "sp_filial"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_filial", True, FMLoadResString(1568)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_oficina"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(1570)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_moneda"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_moneda", True, FMLoadResString(1569)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_help_costos"
                Select Case VGTipo
                    Case "S"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, FConCostos.txtCampo(0).Text)
                        grdRegistros.Row = grdRegistros.Rows - 1
                        grdRegistros.Col = 1
                        PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT4, grdRegistros.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", True, FMLoadResString(1596)) Then
                            PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                            PMMapeaTextoGrid(grdRegistros)
                            PMChequea(sqlconn)
                            cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                            grdRegistros.Row = 1
                        Else
                            PMChequea(sqlconn)
                        End If
                    Case "C"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        grdRegistros.Row = grdRegistros.Rows - 1
                        grdRegistros.Col = 1
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, grdRegistros.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", True, FMLoadResString(1596)) Then
                            PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                            PMMapeaTextoGrid(grdRegistros)
                            PMChequea(sqlconn)
                            cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                            grdRegistros.Row = 1
                        Else
                            PMChequea(sqlconn)
                        End If
                End Select
            Case "sp_prod_bancario"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_valor_contratado"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, FConsultaPer.txtCampo(0).Text)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1590)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_corango_pe"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4048")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, VServicioP)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_pe", True, FMLoadResString(1595)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_help_rubros"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4046")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, CStr(VGSucursalSig))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rubros", True, FMLoadResString(1597)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_mercado"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4023")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, FTrprobaen.txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mercado", True, FMLoadResString(1556)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_help_serv_pe"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", True, FMLoadResString(1596)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_prodfin"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4012")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1553)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_help_rango_pe"
                Exit Sub
            Case "sp_help_cosub"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4039")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_cod_serv", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 2
                PMPasoValores(sqlconn, "@i_cod_detalle", 0, SQLCHAR, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_cosub", True, FMLoadResString(1551)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_promon"
                If VGTipo = "H" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4075")
                Else
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4076")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                End If
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 2
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VGTipo)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_cons_personalizacion"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4067")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_personalizacion", True, FMLoadResString(1596)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_autoriza_trn_caja"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "731")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1564)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_corango_ma"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4080")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, VTipoRango)
                PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, VGrupoRango)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_ma", True, FMLoadResString(1595)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
    End Sub


    Private Sub FRegistros_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 27 Then
            VGACatalogo.Descripcion = ""
            VGACatalogo.Codigo = ""
            For i As Integer = 0 To 10
                VGValores(i) = ""
            Next i
            VGOperacion = ""
            VGTipo = ""
            Me.Close()
        Else
            If KeyAscii = 13 Then
                PLEscoger()
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
        PLEscoger()
    End Sub

    Private Sub grdRegistros_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRegistros.KeyUp
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

    Private Sub PLEscoger()
        Select Case VGOperacion
            Case "sp_help_costos"
                Select Case VGTipo
                    Case "R"
                        If grdRegistros.Rows > 1 Then
                            grdRegistros.Col = 1
                            VGValores(1) = grdRegistros.CtlText
                            grdRegistros.Col = 2
                            VGValores(2) = grdRegistros.CtlText
                            grdRegistros.Col = 3
                            VGValores(3) = grdRegistros.CtlText
                            grdRegistros.Col = 4
                            VGValores(4) = grdRegistros.CtlText
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        Else
                            For i As Integer = 0 To 10
                                VGValores(i) = ""
                            Next i
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        End If
                    Case "C"
                        If grdRegistros.Rows > 1 Then
                            grdRegistros.Col = 1
                            VGACatalogo.Codigo = grdRegistros.CtlText
                            grdRegistros.Col = 2
                            VGACatalogo.Descripcion = grdRegistros.CtlText
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        Else
                            VGACatalogo.Codigo = ""
                            VGACatalogo.Descripcion = ""
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        End If
                    Case "S"
                        If grdRegistros.Rows > 1 Then
                            grdRegistros.Col = 1
                            VGValores(1) = grdRegistros.CtlText
                            grdRegistros.Col = 2
                            VGValores(2) = grdRegistros.CtlText
                            grdRegistros.Col = 3
                            VGValores(3) = grdRegistros.CtlText
                            grdRegistros.Col = 4
                            VGValores(4) = grdRegistros.CtlText
                            grdRegistros.Col = 5
                            VGValores(5) = grdRegistros.CtlText
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        Else
                            For i As Integer = 0 To 10
                                VGValores(i) = ""
                            Next i
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        End If
                End Select
            Case "sp_help_rango_pe"
                Select Case VGTipo
                    Case "T"
                        If grdRegistros.Rows > 1 Then
                            grdRegistros.Col = 1
                            VGValores(1) = grdRegistros.CtlText
                            grdRegistros.Col = 2
                            VGValores(2) = grdRegistros.CtlText
                            grdRegistros.Col = 3
                            VGValores(3) = grdRegistros.CtlText
                            grdRegistros.Col = 4
                            VGValores(4) = grdRegistros.CtlText
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        Else
                            For i As Integer = 0 To 10
                                VGValores(i) = ""
                            Next i
                            VGOperacion = ""
                            Me.Close()
                            Exit Sub
                        End If
                    Case "G"
                        If grdRegistros.Rows > 1 Then
                            grdRegistros.Col = 1
                            VGACatalogo.Codigo = grdRegistros.CtlText
                            VGOperacion = ""
                            VGTipo = ""
                            Me.Close()
                            Exit Sub
                        Else
                            VGACatalogo.Codigo = ""
                            VGOperacion = ""
                            VGTipo = ""
                            Me.Close()
                            Exit Sub
                        End If
                End Select
            Case "sp_promon"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    VGValores(4) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_prodfin"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_prodfin2"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    VGValores(3) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_prodfin3"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    VGValores(5) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_hp_sucursal"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_corango_pe"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    VGValores(4) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_help_rubros"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    VGValores(4) = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    VGValores(5) = grdRegistros.CtlText
                    grdRegistros.Col = 6
                    VGValores(6) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_cons_personalizacion"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_corango_ma"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    VGValores(3) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
            Case "sp_autoriza_trn_caja"
                If grdRegistros.Rows > 1 Then
                    grdRegistros.Col = 1
                    VGValores(1) = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGValores(2) = grdRegistros.CtlText
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                Else
                    For i As Integer = 0 To 10
                        VGValores(i) = ""
                    Next i
                    VGOperacion = ""
                    Me.Close()
                    Exit Sub
                End If
        End Select
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1
            VGACatalogo.Codigo = grdRegistros.CtlText
            grdRegistros.Col = 2
            VGACatalogo.Descripcion = grdRegistros.CtlText
        Else
            VGACatalogo.Codigo = ""
            VGACatalogo.Descripcion = ""
        End If
        VGOperacion = ""
        Me.Close()
    End Sub

    Private Sub FRegistros_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PLTSEstado()
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
        If grdRegistros.Rows >= 2 Then grdRegistros.Row = 1
        PMAnchoColumnasGrid(grdRegistros)
    End Sub

    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = cmdSiguientes.Enabled
        TSBSiguiente.Visible = cmdSiguientes.Visible

    End Sub
    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If cmdSiguientes.Enabled Then cmdSiguientes_Click(cmdSiguientes, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        grdRegistros.Col = 0
        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows Then
            cmdSiguientes.Enabled = True
            grdRegistros.Row = 1
        Else
            cmdSiguientes.Enabled = False
        End If
        VGACatalogo.Descripcion = ""
        VGACatalogo.Codigo = ""
        For i As Integer = 0 To 10
            VGValores(i) = ""
        Next i
        PLTSEstado()
    End Sub

    Private Sub TSBEscoger_Click(sender As Object, e As EventArgs) Handles TSBEscoger.Click
        PLEscoger()
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        Me.Close()
    End Sub

End Class


