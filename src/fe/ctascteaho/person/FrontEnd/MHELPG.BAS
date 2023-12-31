Attribute VB_Name = "MHELPG"
Option Explicit
'*********************************************************
'   Archivo:        MHELPG.BAS
'   Producto:       Master Information Subsystem
'   Dise�ado por:   Myriam D�vila
'   Fecha de Documentaci�n: 14/Ene/94
'*********************************************************
'                       IMPORTANTE
' Esta Aplicaci�n es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido as� como cualquier alteraci�n o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' Descripci�n:  Este m�dulo contiene las rutinas y varia-
'               bles globales que nos permiten utilizar
'               la forma de Help (F5) con un grid.
'               Contiene otras rutinas como la que se�ala
'               una l�nea del grid, limpia el grid, para
'               formatear campos fecha y hora.
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'*********************************************************
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

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

'! Function FLFormatFecha (Fecha As String) As String
'!     aa$ = Mid$(Fecha, 1, 4)
'!     mm$ = Mid$(Fecha, 6, 2)
'!     dd$ = Mid$(Fecha, 9, 2)
'!     s1$ = Mid$(Fecha, 5, 1)
'!     s2$ = Mid$(Fecha, 8, 1)
'!     If s1$ = "/" Then
'!        If s2$ = "/" Then
'!           a% = Val(aa$)
'!           If a% >= 1753 And a% <= 9999 Then
'!              m% = Val(mm$)
'!              If m% >= 1 And m% <= 12 Then
'!                 d% = Val(dd$)
'!                 If d% >= 1 And d% <= 31 Then
'!                    FLFormatFecha = mm$ + "/" + dd$ + "/" + aa$
'!                    Exit Function
'!                 End If
'!              End If
'!           End If
'!        End If
'!     End If
'!     FLFormatFecha = ""
'!     Exit Function
'! End Function
'!
'! Function FLHora (Hora As String) As String
'!     hh$ = Mid$(Hora, 1, 2)
'!     mm$ = Mid$(Hora, 4, 2)
'!     s1$ = Mid$(Hora, 3, 1)
'!     If s1$ = ":" Then
'!           h% = Val(hh$)
'!           If a% >= 0 And a% <= 23 Then
'!              m% = Val(mm$)
'!              If m% >= 0 And m% <= 59 Then
'!                    If m% < 10 Then
'!                     FLHora = hh$ + ":" + "0" + LTrim$(Str$(m%))
'!                    Else
'!                     FLHora = hh$ + ":" + mm$
'!                    End If
'!                    Exit Function
'!              End If
'!           End If
'!     End If
'!     FLHora = ""
'!     Exit Function
'! End Function
'!
'! Sub MensajesVB (Clase As Integer, Numero As Integer, Texto As String)
'!     Select Case Clase
'!     Case 0
'!         Titulo$ = "Error de Conecci�n"
'!     Case 1
'!         Titulo$ = "Control de Ingreso de Valores"
'!     Case 2
'!         Titulo$ = "Valores Permisibles"
'!     Case 3
'!         Titulo$ = "Navegaci�n de Registros"
'!     End Select
'!     Beep
'!     MsgBox Texto$, 0 + Numero%, Titulo$
'! End Sub
'!
Sub PMBuscarG(posicion As Integer, nombre As String, valor As String, tipo As Integer)
'*********************************************************
'Objetivo:  Dada una posicion en el arreglo de par�metros
'           fija el nombre, valor y tipo de dato del par�metro
'Input   :  posicion        item del arreglo
'           nombre          nombre del par�metro
'           valor           valor del par�metro
'           tipo            tipo del par�metro
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisi�n Inicial
'*********************************************************
    AGBuscar(posicion).nombre = nombre
    AGBuscar(posicion).valor = valor
    AGBuscar(posicion).tipo = tipo
End Sub

Sub PMHelpG(base_datos As String, stored_procedure As String, par_buscar As Integer, par_sig As Integer)
'*********************************************************
'Objetivo:  Inicializa las variables globales que permiten
'           utilizar la ventana de ayuda con grid.
'Input   :  base_datos          base de datos del stored proc.
'           stored_procedure    nombre del sp
'           par_buscar          n�mero de par�metros para bot�n buscar
'           par_sig             n�mero de par�metros adicionales para bot�n siguientes
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisi�n Inicial
'*********************************************************
    grid_valores.dl_sp.Caption = stored_procedure
    VGPBuscar% = par_buscar
    VGPSiguiente% = par_sig
    VGBaseDatos$ = base_datos
    ReDim AGBuscar(VGPBuscar%)
    ReDim AGSiguiente(VGPSiguiente%)
End Sub

Sub PMLimpiaG(GridControl As Object)
'*********************************************************
'Objetivo:  Limpia el contenido de un grid.
'Input   :  GridControl     el grid a limpiar
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisi�n Inicial
'*********************************************************
Dim i%
Dim j%
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

Sub PMLineaG(GridControl As Object)
'*********************************************************
'Objetivo:  Marca una l�nea del grid como seleccionada
'Input   :  GridControl     el grid
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisi�n Inicial
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
'Objetivo:  Seg�n el n�mero de l�neas del grid de ayuda,
'           habilita o deshabilita el bot�n siguientes
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisi�n Inicial
'*********************************************************
     If grid_valores.gr_SQL.Rows >= VGMaximoRows% Then
         grid_valores.bb_siguiente.Enabled = True
     Else
        grid_valores.bb_siguiente.Enabled = False
     End If
End Sub

'! Sub PMSigteG (posicion As Integer, nombre As String, Col As Integer, tipo As Integer)
'! '*********************************************************
'! 'Objetivo:  Dada una posicion en el arreglo de par�metros
'! '           siguientes fija el nombre, valor, tipo de dato
'! '           y columna en el grid correspondientes al par�metro
'! 'Input   :  posicion        item del arreglo
'! '           nombre          nombre del par�metro
'! '           Col             columna en el grid
'! '           tipo            tipo del par�metro
'! 'Output  :  ninguno
'! '*********************************************************
'! '                    MODIFICACIONES
'! 'FECHA      AUTOR               RAZON
'! '01/Ago/93  M.Davila            Emisi�n Inicial
'! '*********************************************************
'!     AGSiguiente(posicion).nombre = nombre
'!     AGSiguiente(posicion).Col = Col
'!     AGSiguiente(posicion).tipo = tipo
'! End Sub
'!
'!

