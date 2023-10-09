Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Partial Public Class FAyudaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdSeleccion_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSeleccion_3.Click, _cmdSeleccion_2.Click, _cmdSeleccion_1.Click, _cmdSeleccion_0.Click
        Dim Index As Integer = Array.IndexOf(cmdSeleccion, eventSender)
        Select Case Index
            Case 0
                PLBuscar(VGOperacion)
            Case 1
                PLSiguientes(VGOperacion)
            Case 2
                PLSeleccionar()
            Case 3
                PLSalir()
        End Select
    End Sub

    Private Sub cmdSeleccion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSeleccion_3.Enter, _cmdSeleccion_2.Enter, _cmdSeleccion_1.Enter, _cmdSeleccion_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdSeleccion, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500011))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500012))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2518))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500906))
        End Select
    End Sub

    Private Sub FAyuda_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 27 Then
            PLSalir()
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub FAyuda_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" 'JSA
        PLInicializar() 'JSA
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        PLBuscar(VGOperacion)
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
        PLSeleccionar()
    End Sub

    Private Sub grdRegistros_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRegistros.KeyDown

    End Sub

    Private Sub grdRegistros_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles grdRegistros.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 13 Then
            PLSeleccionar()
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLBuscar(ByRef Tipo As String)
        Select Case Tipo
            Case "sp_tipo_plan"
                Me.Text = "Lista de Plan Tipo"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6007")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_tipo_plan", True, FMLoadResString(509206)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "cb_categoria"
                Me.Text = "Lista de Categorías"
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cb_categoria")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509206)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_moneda"
                Me.Text = "Lista de Monedas"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1556")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_moneda", True, FMLoadResString(509148)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_empresa"
                Me.Text = "Lista de Empresas"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6037")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_empresa", True, FMLoadResString(509208)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_oficina"
                Me.Text = "Lista de Entidades"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6157")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_oficina", True, FMLoadResString(509209)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_organizacion"
                Me.Text = "Lista de Niveles Organizacionales"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6057")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_organizacion", True, FMLoadResString(509210)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_relacion"
                Me.Text = "Lista de Cuentas de Movimiento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6070")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_relacion", True, FMLoadResString(509211)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_cuenta_movimiento"
                Me.Text = "Lista de Cuentas de Movimiento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6077")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_departamento", 0, SQLINT2, VGAyuda(4))
                PMPasoValores(sqlconn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_cuenta_movimiento", True, FMLoadResString(509211)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_comp_tipo"
                Me.Text = "Lista de Comprobantes Tipo"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6127")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_comp_tipo", True, FMLoadResString(509212)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6197")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_departamento", True, FMLoadResString(2465)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_oficina_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6247")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_oficina_departamento", True, FMLoadResString(2465)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_periodo"
                Me.Text = "Lista de Períodos Contables"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6097")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_periodo", True, FMLoadResString(509213)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_nivel_departamento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6185")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_nivel_departamento", True, FMLoadResString(509214)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_seccion"
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ca_seccion")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509215)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_proceso"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_proceso", True, FMLoadResString(509216)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_batch"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8007")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_batch", True, FMLoadResString(509216)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_pro_transaccion"
                Me.Text = "Lista de Transacciones"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VGAyuda(3))
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "8")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(20001)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_parametriza_sol"
                Me.Text = "Grupos Solicitud de Productos"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "162")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametriza_sol", True, FMLoadResString(509217)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_alianzas"
                Me.Text = "Alianzas Comerciales"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1615")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_alianzas", True, FMLoadResString(509218)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
            cmdSeleccion(2).Enabled = True
            cmdSeleccion(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            cmdSeleccion(2).Enabled = False
        End If
    End Sub

    Private Sub PLSalir()
        ReDim VGAyuda(5)
        For i As Integer = 1 To 5
            VGAyuda(i) = ""
        Next i
        'JSA Me.Close()
        Me.Dispose()
    End Sub

    Private Sub PLSeleccionar()
        If (grdRegistros.Cols - 1) = 1 Then
            ReDim VGAyuda(5)
            For i As Integer = 1 To 5
                VGAyuda(i) = ""
            Next i
        Else
            ReDim VGAyuda(grdRegistros.Cols - 1)
            For i As Integer = 1 To grdRegistros.Cols - 1
                grdRegistros.Col = i
                VGAyuda(i) = grdRegistros.CtlText
            Next i
        End If
        'JSA Me.Close()
        Me.Dispose()
    End Sub

    Private Sub PLSiguientes(ByRef Tipo As String)
        Select Case Tipo
            Case "sp_tipo_plan"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6007")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_tipo_plan", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_tipo_plan", True, FMLoadResString(509206)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_moneda"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1556")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_moneda", True, FMLoadResString(509148)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_empresa"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6037")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_empresa", True, FMLoadResString(509208)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_oficina"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6157")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_oficina", True, FMLoadResString(509209)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_organizacion"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6057")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_organizacion", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_organizacion", True, FMLoadResString(509210)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_relacion"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6070")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_relacion", True, FMLoadResString(509220)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_cuenta_movimiento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6077")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_departamento", 0, SQLINT2, VGAyuda(4))
                PMPasoValores(sqlconn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_cuenta_movimiento", True, FMLoadResString(2526)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_comp_tipo"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6127")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_comp_tipo", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_comp_tipo", True, FMLoadResString(509212)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_oficina_departamento"
                Me.Text = FMLoadResString(509225)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6247")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_departamento", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_oficina_departamento", True, FMLoadResString(2465)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_departamento"
                Me.Text = FMLoadResString(509225)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6197")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_departamento", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_departamento", True, FMLoadResString(2535)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_periodo"
                Me.Text = FMLoadResString(509224)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6097")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_periodo", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_periodo", True, FMLoadResString(509213)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_nivel_departamento"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6185")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_nivel", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, DatabaseName, "sp_nivel_departamento", True, FMLoadResString(509214)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_proceso"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_proceso", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_proceso", True, FMLoadResString(509216)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_batch"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8007")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_batch", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_batch", True, FMLoadResString(509216)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_pro_transaccion"
                Me.Text = FMLoadResString(509223)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGAyuda(2))
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VGAyuda(3))
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "9")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(20001)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_alianzas"
                Me.Text = FMLoadResString(509222)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1615")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_alianzas", True, FMLoadResString(509218)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        cmdSeleccion(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdSeleccion_0.Enabled Then cmdSeleccion_Click(_cmdSeleccion_0, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSigtes.Click
        If _cmdSeleccion_1.Enabled Then cmdSeleccion_Click(_cmdSeleccion_1, e)
    End Sub

    Private Sub TSBSigtes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdSeleccion_2.Enabled Then cmdSeleccion_Click(_cmdSeleccion_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSeleccion_3.Enabled Then cmdSeleccion_Click(_cmdSeleccion_3, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdSeleccion_0.Enabled
        TSBBuscar.Visible = _cmdSeleccion_0.Visible
        TSBSigtes.Enabled = _cmdSeleccion_1.Enabled
        TSBSigtes.Visible = _cmdSeleccion_1.Visible
        TSBEscoger.Enabled = _cmdSeleccion_2.Enabled
        TSBEscoger.Visible = _cmdSeleccion_2.Visible
        TSBSalir.Enabled = _cmdSeleccion_3.Enabled
        TSBSalir.Visible = _cmdSeleccion_3.Visible
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500121))
    End Sub
End Class


