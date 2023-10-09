Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FAyudaClass
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
        MyAppGlobals.AppActiveForm = ""
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
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        If KeyCode = 115 Then
            PMCopyClip(grdRegistros)
        End If
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
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6007")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_tipo_plan", True, " Consulta de tipos de planes") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "cb_categoria"
                Me.Text = "Lista de Categorías"
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_tabla", 0, SQLVARCHAR, "cb_categoria")
                PMPasoValores(SqlConn, "@i_filial", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, "1")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de categorías") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_moneda"
                Me.Text = "Lista de Monedas"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1556")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_moneda", True, " Consulta de monedas") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_empresa"
                Me.Text = "Lista de Empresas"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6037")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_empresa", True, " Consulta de empresas") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_oficina"
                Me.Text = "Lista de Entidades"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6157")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_oficina", True, " Consulta de entidades") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_organizacion"
                Me.Text = "Lista de Niveles Organizacionales"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6057")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_organizacion", True, " Lista de niveles jerárquicos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_relacion"
                Me.Text = "Lista de Cuentas de Movimiento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6070")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_relacion", True, " Consulta de cuentas de movimiento") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_cuenta_movimiento"
                Me.Text = "Lista de Cuentas de Movimiento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6077")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_departamento", 0, SQLINT2, VGAyuda(4))
                PMPasoValores(SqlConn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_cuenta_movimiento", True, " Consulta de cuentas de movimiento") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_comp_tipo"
                Me.Text = "Lista de Comprobantes Tipo"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6127")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_comp_tipo", True, " Lista de comprobantes tipo") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6197")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_departamento", True, " Consulta de departamentos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_oficina_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6247")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_oficina_departamento", True, " Consulta de departamentos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_periodo"
                Me.Text = "Lista de Períodos Contables"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6097")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_periodo", True, " Lista de períodos contables") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_nivel_departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6185")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_nivel_departamento", True, " Lista de niveles departamentales") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_seccion"
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_tabla", 0, SQLCHAR, "ca_seccion")
                PMPasoValores(SqlConn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_hp_catalogo", True, " Lista de secciones bancarias") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_proceso"
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, "cob_conta", "sp_proceso", True, " Lista de procesos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_batch"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "8007")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_batch", True, " Lista de procesos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_pro_transaccion"
                Me.Text = "Lista de Transacciones"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(SqlConn, "@i_producto", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_moneda", 0, SQLINT1, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, VGAyuda(3))
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "8")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_pro_transaccion", True, " Consulta de transacciones") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_parametriza_sol"
                Me.Text = "Grupos Solicitud de Productos"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "162")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_parametriza_sol", True, " Consulta Grupos Solictud Productos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
                End If
            Case "sp_alianzas"
                Me.Text = "Alianzas Comerciales"
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1615")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
                    PMMapeaGrid(SqlConn, grdRegistros, False)
                    PMChequea(SqlConn)
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
        Me.Close()
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
        Me.Close()
    End Sub

    Private Sub PLSiguientes(ByRef Tipo As String)
        Select Case Tipo
            Case "sp_tipo_plan"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6007")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_tipo_plan", 0, SQLCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_tipo_plan", True, " Consulta de tipos de planes") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_moneda"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1556")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_moneda", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_moneda", True, " Consulta de monedas") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_empresa"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6037")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_empresa", True, " Consulta de empresas") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_oficina"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6157")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_oficina", True, " Consulta de entidades") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_organizacion"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6057")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_organizacion", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_organizacion", True, " Lista de niveles jerárquicos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_relacion"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6070")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_cuenta", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_relacion", True, " Lista de cuentas de movimiento") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_cuenta_movimiento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6077")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT2, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_departamento", 0, SQLINT2, VGAyuda(4))
                PMPasoValores(SqlConn, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_cuenta", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_cuenta_movimiento", True, " Lista de cuentas de movimiento") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_comp_tipo"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6127")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_comp_tipo", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_comp_tipo", True, " Lista de comprobantes tipo") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_oficina_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6247")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, VGAyuda(2))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_departamento", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_oficina_departamento", True, " Consulta de departamentos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_departamento"
                Me.Text = "Lista de Departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6197")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_departamento", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_departamento", True, " Consulta de departamentos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_periodo"
                Me.Text = "Lista de Períodos Contables"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6097")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_periodo", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_periodo", True, " Lista de períodos contables") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_nivel_departamento"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6185")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_nivel", 0, SQLINT1, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, DatabaseName, "sp_nivel_departamento", True, " Lista de niveles departamentales") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_proceso"
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_proceso", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, "cob_conta", "sp_proceso", True, " Lista de procesos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_batch"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "8007")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_batch", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_batch", True, " Lista de procesos") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_pro_transaccion"
                Me.Text = "Lista de Transacciones"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(SqlConn, "@i_producto", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(SqlConn, "@i_moneda", 0, SQLINT1, VGAyuda(2))
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, VGAyuda(3))
                PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "9")
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "S")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(SqlConn, "@i_transaccion", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_pro_transaccion", True, " Consulta de transacciones") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
            Case "sp_alianzas"
                Me.Text = "Alianzas Comerciales"
                PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1615")
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
                    PMMapeaGrid(SqlConn, grdRegistros, True)
                    PMChequea(SqlConn)
                End If
        End Select
        cmdSeleccion(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdSeleccion_0.Enabled
        TSBBuscar.Visible = _cmdSeleccion_0.Visible
        TSBSiguientes.Enabled = _cmdSeleccion_1.Enabled
        TSBSiguientes.Visible = _cmdSeleccion_1.Visible
        TSBEscoger.Enabled = _cmdSeleccion_2.Enabled
        TSBEscoger.Visible = _cmdSeleccion_2.Visible
        TSBSalir.Enabled = _cmdSeleccion_3.Enabled
        TSBSalir.Visible = _cmdSeleccion_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdSeleccion_0.Enabled Then TSBBuscar_Click(_cmdSeleccion_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdSeleccion_1.Enabled Then TSBSiguientes_Click(_cmdSeleccion_1, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdSeleccion_2.Enabled Then TSBEscoger_Click(_cmdSeleccion_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSeleccion_3.Enabled Then TSBSalir_Click(_cmdSeleccion_3, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
            Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        End If
    End Sub
End Class

