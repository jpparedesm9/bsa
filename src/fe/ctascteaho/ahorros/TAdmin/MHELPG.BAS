Attribute VB_Name = "Module2"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   ARCHIVO:        MHELPG.BAS
'   NOMBRE LOGICO:  Module2
'   PRODUCTO:       Master Information Subsystem
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
'                   PROPOSITO
' Descripción:  Este módulo contiene las rutinas y varia-
'               bles globales que nos permiten utilizar
'               la forma de Help (F5) con un grid.
'               Contiene otras rutinas como la que señala
'               una línea del grid, limpia el grid, para
'               formatear campos fecha y hora.
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'*********************************************************
'                     MODIFICACIONES
'   FECHA             AUTOR             RAZON
'   14/Ene/94         Myriam Dávila
'*********************************************************


Rem ********************************************************************
Rem  Tipos de datos y variables para manejo de Help con grid
Rem ********************************************************************

Type RegistroREC
    nombre As String
    valor  As String
    tipo   As Integer
End Type

Type RegistroSIG
    nombre As String
    Col As Integer
    tipo As Integer
End Type

Global AGBuscar() As RegistroREC
Global AGSiguiente() As RegistroSIG
Global Temporales() As String

Global VGPBuscar%
Global VGPSiguiente%
Global VGBaseDatos$

Sub PMBuscarG(posicion As Integer, nombre As String, valor As String, tipo As Integer)
'*********************************************************
'PROPOSITO: Dada una posicion en el arreglo de parámetros
'           fija el nombre, valor y tipo de dato del parámetro
'INPUT   :  posicion        item del arreglo
'           nombre          nombre del parámetro
'           valor           valor del parámetro
'           tipo            tipo del parámetro
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    AGBuscar(posicion).nombre = nombre
    AGBuscar(posicion).valor = valor
    AGBuscar(posicion).tipo = tipo
End Sub

Sub PMHelpG(base_datos As String, stored_procedure As String, par_buscar As Integer, par_sig As Integer)
'*********************************************************
'PROPOSITO: Inicializa las variables globales que permiten
'           utilizar la ventana de ayuda con grid.
'INPUT   :  base_datos          base de datos del stored proc.
'           stored_procedure    nombre del sp
'           par_buscar          número de parámetros para botón buscar
'           par_sig             número de parámetros adicionales para botón siguientes
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    grid_valores.dl_sp.Caption = stored_procedure
    VGPBuscar% = par_buscar
    VGPSiguiente% = par_sig
    VGBaseDatos$ = base_datos
    ReDim AGBuscar(VGPBuscar%)
    ReDim AGSiguiente(VGPSiguiente%)
End Sub

Sub PMLimpiaG(GridControl As Control)
'*********************************************************
'PROPOSITO: Limpia el contenido de un grid.
'INPUT   :  GridControl     el grid a limpiar
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
  If TypeOf GridControl Is Grid Then
     GridControl.Tag = "0"
'FIXIT: 'FixedRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'FixedRows' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
     GridControl.FixedRows = 1
'FIXIT: 'FixedCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'FixedCols' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
     GridControl.FixedCols = 1
'FIXIT: 'Cols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Cols' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
     GridControl.Cols = 2
'FIXIT: 'Rows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Rows' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
     GridControl.Rows = 2
     For i% = 0 To 1
        For j% = 0 To 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.Row = i%
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.Col = j%
            GridControl.Text = ""
        Next j%
     Next i%
  End If
End Sub

Sub PMLineaG(GridControl As Control)
'*********************************************************
'PROPOSITO: Marca una línea del grid como seleccionada
'INPUT   :  GridControl     el grid
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
'FIXIT: 'Rows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Rows' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    If GridControl.Rows >= 2 Then
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        If GridControl.Row > 0 Then
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.Col = 0
'FIXIT: 'SelStartCol' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'SelStartCol' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.SelStartCol = 1
'FIXIT: 'SelEndCol' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'SelEndCol' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Cols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Cols' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.SelEndCol = GridControl.Cols - 1
'FIXIT: 'SelStartRow' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'SelStartRow' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.SelStartRow = GridControl.Row
'FIXIT: 'SelEndRow' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'SelEndRow' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'GridControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            GridControl.SelEndRow = GridControl.Row
        End If
    End If
End Sub

Sub PMProcesG()
'*********************************************************
'PROPOSITO: Según el número de líneas del grid de ayuda,
'           habilita o deshabilita el botón siguientes
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
 If grid_valores.dl_sp.Caption <> "sp_hp_catalogo" Then
     If grid_valores.gr_SQL.Rows >= VGMaximoRows% Then
         grid_valores.bb_siguiente.Enabled = True
     Else
        grid_valores.bb_siguiente.Enabled = False
     End If
 Else
    grid_valores.bb_siguiente.Enabled = False
 End If
End Sub

Sub PMSigteG(posicion As Integer, nombre As String, Col As Integer, tipo As Integer)
'*********************************************************
'PROPOSITO: Dada una posicion en el arreglo de parámetros
'           siguientes fija el nombre, valor, tipo de dato
'           y columna en el grid correspondientes al parámetro
'INPUT   :  posicion        item del arreglo
'           nombre          nombre del parámetro
'           Col             columna en el grid
'           tipo            tipo del parámetro
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    AGSiguiente(posicion).nombre = nombre
    AGSiguiente(posicion).Col = Col
    AGSiguiente(posicion).tipo = tipo
End Sub


