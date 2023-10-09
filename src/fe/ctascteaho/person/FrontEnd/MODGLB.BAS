Attribute VB_Name = "MODGLB"
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR              RAZON
' 26/May/98     Geovanna Bonilla B. Migracion VB3 a VB5
'*************************************************************
'GBB26May98008 II:Se debe hacer un load a la forma antes de cargar los valores
        
Global VGDecimales As String
Global VGPaso As Integer
Global VGConsulta As Integer
Global VGOperacion As String
'! removed Global VGADatosI() As String

'! removed Global VGADatosO() As String

Global VGProducto() As String
Global VGDetalle() As String
Global VGTeclaAyuda As Integer
Global VGPersonaliza As Integer
Global VGCuenta As String
Global VGValores(10) As String
Global VGTipo As String
Global VGProd As String
Global VGFecha As String
Global VGFormatoFecha As String
Global VGForma As String
Global VGDebug As Integer
Type CatalogoUsuario
    Codigo As String
    Descripcion As String
End Type
Global VGACatalogo As CatalogoUsuario 'Variable utilizada para llama al catálogo por F5

Global VGFilial As String             'Código de la filial
Global VGOficina As String            'Código de la oficina
Global VGMoneda As String             'Código de la moneda
Global VGRol As String                'Código del rol del usuario
Global VGLongCtaCte As Integer       'Longitud de la cuenta corriente
Global VGLongCtaAho As Integer       'Longitud de la cuenta de ahorros
Global VGPesosCtaCte As String       'Pesos de la cuenta corriente
Global VGPesosCtaAho As String       'Pesos de la cuenta de ahorros
Global VGModuloCtaCte As Integer     'Modulo de la cuenta corriente
Global VGModuloCtaAho As Integer     'Modulo de la cuenta de ahorros
Global VGMascaraCtaCte As String     'Mascara de la cuenta corriente
Global VGMascaraCtaAho As String     'Mascara de la cuenta de ahorros
'! removed Global VGImagenComp As String
'Utilizada para el scanner de las firmas
'! removed Global VGTIMERMAIL As Integer
'Contador del poleo del correo elctrónico
Global VGCorreo As Integer           'Permite habilitar el correo electrónico
Global VGPath As String
Global VGBusqueda()  As String
Global VGBanco As String
Global VGPais As String
Public FMain As FPrincipal

Global VGLogTransacciones As String     ' Nombre del archivo de log de transacciones
Global sqlconn&                      'Handle to SQL Server connection
Global ServerName$                   'Name of SQL Server connected to
Global ServerNameLocal$
Global VGLogin$                      'SQL Server login ID
Global Password$                     'SQL Server password
Global DatabaseName$                 'Current database name
Global HostName$                     'Current Host Name
'! removed Global LoginTimeout%
'Max time to wait for login
'! removed Global QueryTimeout%
'Max time to wait for query results

Global Const VGMaximoRows% = 16
Global Const VGMaxRows% = 15
Global Const CGFormatoBase$ = "mm/dd/yyyy" 'Formato SYBASE
Global formato_fecha() As String 'Matriz con los formatos y codigos Ej. mm/dd/yyyy - 101
Global VGFecha_SP As String      'Código para formato de fecha

Global VGSucursalSig% 'JFC: Para boton Siguientes: sp_help_rubros

Global PathUnico As String

Public Sub PMBorrarGrid(parSSControl As Object)
'*************************************************************
'PROPOSITO: Borra todo el contenido de un grid especificado
' INPUT    :  parSSControl   'Grid seleccionado
' OUTPUT   :  Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 16-Oct-98      S.Garcés        Emision Inicial
'*************************************************************

'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    If parSSControl.MaxRows > 0 Then
        'Seleccionar bloque de celdas
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row = 1
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col = 0
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row2 = parSSControl.MaxRows
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col2 = parSSControl.MaxCols
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = True
        'Borrar datos del grid
'FIXIT: 'Action' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Action' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Action' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Action' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Action = 12
        'Deshabilitar bloque
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = False
        
        'Eliminar filas existentes
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.MaxRows = 0
    End If
End Sub
Public Sub PMMarcaFilaGrid(parSSControl As Object, parRow As Long)
'*************************************************************
'PROPOSITO: Marca la fila de un grid cuando ésta es
'             seleccionada
' INPUT    :  parSSControl   'Grid seleccionado
'             parRow         'Fila selccionada
' OUTPUT   :  Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 23/Dic/97      S.Garcés        Emision Inicial
'*************************************************************

    If parRow > -1 Then     'el grid no pierde el foco
        'marcar todo el grid y deseleccionarlo
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col = 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row = 1
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col2 = parSSControl.MaxCols
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row2 = parSSControl.MaxRows
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = True
        parSSControl.BackColor = vbWindowBackground
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = False

        ' Sombrea el registro seleccionado con color amarillo
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col = 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row = parRow
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col2 = parSSControl.MaxCols
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row2 = parRow
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = True
        parSSControl.BackColor = vbInfoBackground '&HC0FFFF
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = False
    End If
    
End Sub
Public Sub PMBloqueaGrid(parSSControl As Object)
'*************************************************************
'PROPOSITO:  Bloquear la edición en un grid especificado
' INPUT    :  parSSControl   'Grid seleccionado
' OUTPUT   :  Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Nov-98      S.Garcés        Emision Inicial
' 21-Feb-2000    X. Ramos        Verificación de existencia de
'                                filas en el objeto.
'*************************************************************

'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    If parSSControl.MaxRows > 0 Then
        'Bloquear edición en el grid
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row = 1
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col = 1
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxRows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxRows' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row2 = parSSControl.MaxRows
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'MaxCols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Col2' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col2' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Col2 = parSSControl.MaxCols
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = True
'FIXIT: 'Lock' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Lock' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Lock' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Lock' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Lock = True
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'BlockMode' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'BlockMode' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.BlockMode = False
'FIXIT: 'ActiveRow' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ActiveRow' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'ActiveRow' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ActiveRow' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'parSSControl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        parSSControl.Row = parSSControl.ActiveRow
    End If
    
End Sub

Function FMValidarNumero(parValor As String, parLongitud As Integer, parcaracter As Integer, parNemonico As String) As Integer

  Dim VTDecimal As Integer
  Dim VTSeparadorDecimal As String
Dim CGTeclaMenos%
  VTSeparadorDecimal$ = "."

  VTDecimal% = 2
  If parcaracter% = CGTeclaMenos% Then
    'CHM 08-nov-99
    FMValidarNumero% = 0
    Exit Function
  End If

  If (VTDecimal% > 0) Then
      If (InStr(1, parValor, VTSeparadorDecimal$)) >= (parLongitud + (VTDecimal) + 1) Then
        FMValidarNumero% = 0
      Else
        FMValidarNumero% = parcaracter%
      End If
  Else
    If Len(parValor) >= parLongitud Then
      FMValidarNumero% = 0
    Else
      FMValidarNumero% = parcaracter%
    End If
  End If

End Function

Function FMChequeaCtaAho(Cuenta As String) As Integer
' cambio para banco Agrario
' Julissa Colorado
Dim VTSum%
Dim j%
Dim VTFirst%
Dim i%
Dim VTProducto%
Dim VTModulo%
    If Len(Cuenta$) < VGLongCtaAho% Then
        FMChequeaCtaAho% = False
        Exit Function
    End If
    
    VTSum% = 0
    j% = 1
    VTFirst% = Val(Mid$(Cuenta$, 1, 1))
    For i% = (VGLongCtaAho% - Len(Cuenta$) + 1) To VGLongCtaAho% - 1
     
        VTProducto% = Val(Mid$(Cuenta$, j%, 1)) * Val(Mid$(VGPesosCtaAho$, i%, 1))
        
        VTSum% = VTSum% + VTProducto%
   
        j% = j% + 1
    Next i%
    VTModulo% = VTSum% Mod VGModuloCtaAho%
    
    If VTModulo% = 0 Then
       VTModulo% = 0
    Else
       If VTModulo% = 1 Then
          VTModulo% = 1
       Else
          VTModulo% = VGModuloCtaAho% - VTModulo%
       End If
    End If
    
    
    If VTModulo% <> Val(Mid$(Cuenta$, VGLongCtaAho%, 1)) Then
        FMChequeaCtaAho% = False
    Else
        FMChequeaCtaAho% = True
    End If
End Function

Function FMChequeaCtaCte(Cuenta As String) As Integer
Dim VTSum%
Dim j%
Dim VTFirst%
Dim i%
Dim VTProducto%
Dim VTModulo%
    If Len(Cuenta$) < VGLongCtaCte% Then
        FMChequeaCtaCte% = False
        Exit Function
    End If
    VTSum% = 0
    j% = 1
    VTFirst% = Val(Mid$(Cuenta$, 1, 1))
    For i% = (VGLongCtaCte% - Len(Cuenta$) + 1) To VGLongCtaCte% - 1
      'II VMA 8-jun-2001 Banco Tequendama
        VTProducto% = Val(Mid$(Cuenta$, j%, 1)) * Val(Mid$(VGPesosCtaCte$, i%, 1))
        If VTProducto% > 9 Then
           'Inicio Cambio JG Nov 6 2002
           'VTProducto% = VTProducto% - 9
           VTProducto% = Fix(VTProducto% / 10) + (VTProducto% Mod 10)
           'Fin Cambio JG Nov 6 2002
        End If
      'FI VMA 8-jun-2001
      'IU VMA 8-jun-2001
       'VTSum% = VTSum% + Val(Mid$(Cuenta$, J%, 1)) * Val(Mid$(VGPesosCtaCte$, I%, 1))
        VTSum% = VTSum% + VTProducto%
      'FU VMA 8-jun-2001
        j% = j% + 1
    Next i%
    VTModulo% = VTSum% Mod VGModuloCtaCte%

    'If VTModulo% >= (VGModuloCtaCte% - 9) Then
    '    VTModulo% = VGModuloCtaCte% - VTModulo%
    'Else
    '    VTModulo% = 0
        ' Cambiado para Banco de Préstamos MACOSA: 9/26/95
    'End If
    'Implementacion Banco Agrario CLeon May 31 2003
    If VTModulo% = 0 Then
       VTModulo% = 0
    Else
       'If VTModulo% = 1 Then
       '   VTModulo% = 1
       'Else
          VTModulo% = VGModuloCtaCte% - VTModulo%
       'End If
    End If

    If VTModulo% <> Val(Mid$(Cuenta$, VGLongCtaCte%, 1)) Then
        FMChequeaCtaCte% = False
    Else
        FMChequeaCtaCte% = True
    End If
End Function


Function FMMascara(Variable As String, Mascara As String) As String
Dim VTtxt$
Dim i%
Dim j%
Dim VTDigito$
    VTtxt$ = ""
    If Variable$ = "" Then
        For i% = 1 To Len(Mascara$)
            If Mid$(Mascara$, i%, 1) = "#" Then
                VTtxt$ = VTtxt$ & "_"
            Else
                VTtxt$ = VTtxt$ & "-"
            End If
       Next i%
    Else
        j% = 1
        For i% = 1 To Len(Mascara$)
            If Mid$(Mascara$, i%, 1) = "#" Then
                VTDigito$ = Mid$(Variable$, j%, 1)
                If VTDigito$ <> "" Then
                    VTtxt$ = VTtxt$ & VTDigito$
                Else
                    VTtxt$ = VTtxt$ & "_"
                End If
                j% = j% + 1
            Else
                VTtxt$ = VTtxt$ & "-"
            End If
        Next i%
    End If
    FMMascara$ = VTtxt$
End Function

'FIXIT: Declare 'FMValidaTipoDato' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Function FMValidaTipoDato(TipoDato As String, valor As Integer)
    FMValidaTipoDato = valor%
    Select Case TipoDato$
    Case "N"
        If (valor% <> 8) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If
    Case "A"
        If (valor% <> 8) And ((valor% < 65) Or (valor% > 90)) And ((valor% < 97) Or (valor% > 122)) Then
            FMValidaTipoDato = 0
        Else
            FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
        End If
    Case "B"
        FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
    Case "M"
        If (valor% <> 8) And (valor% <> 46) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If
    End Select
End Function

Function FMVerificar_WinIni() As Integer
'*************************************************************
' Objetivo: Función que permite actualizar la configuración
'           de formatos numéricos del Panel de Control de
'           Windows según estándares uilizados en el
'           módulo COBIS - Personalización
' Input   : Ninguno
' Output  : Si retorna True, no se deberá permitir la
'           ejecución de COBIS-Personalización. Si retorna False,
'           se deberá permitir la ejecución del módulo
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR              RAZON
' 03-Jul-96      M. del Pozo        Emision Inicial
' 11-Jul-96      S. Garcés          Cambiar entrada de fecha
' 26/May/98     Geovanna Bonilla B. Migracion VB3 a VB5
'*************************************************************
'GBB26May98004 II: Reemplazo de la funcion Getprofilestring por FMGetSeparadorMiles
'GBB26May98005 II: Reemplazo de la funcion Getprofilestring por FMGetSeparadorDecimales
'GBB26May98006 II: Reemplazo de la funcion Getprofilestring por FMGetFormatoFecha
    
Dim VTProblema As Integer
Dim VTFormatoFecha As String
Dim VTFechaPref As String
Dim VTiDate As String
Dim VTMillar As String
Dim VTDecimal As String
'! removed Dim VTRetval As Integer

Dim VTMsg As String

    VTProblema% = False
    FMVerificar_WinIni = False
    'verificar formato fecha de las pref.
    Select Case VGFormatoFecha$
        Case "mm/dd/yyyy"
            VTFechaPref$ = "MM/dd/yyyy"
            VTiDate$ = "0"
        Case "dd/mm/yyyy"
            VTFechaPref$ = "dd/MM/yyyy"
            VTiDate$ = "1"
        Case Else
            VTFechaPref$ = "yyyy/MM/dd"
            VTiDate$ = "2"
    End Select

    'Comprobar configuración de millares
    VTMillar$ = String$(255, 32)
    VTDecimal$ = String$(255, 32)
    VTFormatoFecha$ = String$(255, 32)

    'Leer archivo win.ini, entrada de miles
    
    'GBB26May98004 II:
    'Reemplazo de la funcion Getprofilestring por FMGetSeparadorMiles
        VTMillar$ = FMGetSeparadorMiles()
        If VTMillar$ = "" Then
            VTMsg$ = "Archivo win.ini o entrada sThousand no encontrados."
            MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
        Exit Function
        End If
        If VTMillar$ <> "," Then VTProblema% = True
    
        'VTRetval% = GetProfileString("intl", "sThousand", "", VTMillar$, Len(VTMillar$))
        'If VTRetval% < 1 Then
        '    VTMsg$ = "Archivo win.ini o entrada sThousand no encontrados."
        '    MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
        '    Exit Function
        'End If
        'VTMillar$ = Mid$(VTMillar$, 1, VTRetval%)
    'GBB26May98004 IF:
    
    'Leer archivo win.ini, entrada de decimales
    
    'GBB26May98005 II:
    'Reemplazo de la funcion Getprofilestring por FMGetSeparadorDecimales
    
    'VTRetval% = GetProfileString("Intl", "sDecimal", "", VTDecimal$, Len(VTDecimal$))
    'If VTRetval% < 1 Then
    '    VTMsg$ = "Archivo win.ini o entrada sDecimal no encontrados."
    '    MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
    '    Exit Function
    'End If
    'VTDecimal$ = Mid$(VTDecimal$, 1, VTRetval%)
        VTDecimal$ = FMGetSeparadorDecimales()
        If VTDecimal$ = "" Then
            VTMsg$ = "Archivo win.ini o entrada sDecimal no encontrados."
            MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
        Exit Function
        End If
        If VTDecimal$ <> "." Then VTProblema% = True
    'GBB26May98005 IF:
    
    'Leer archivo win.ini, entrada de fecha
    'GBB26May98006 II:
    'Reemplazo de la funcion Getprofilestring por FMGetFormatoFecha
        'VTRetval% = GetProfileString("intl", "sShortDate", "", VTFormatoFecha$, Len(VTFormatoFecha$))
        'If VTRetval% < 1 Then
        '    VTMsg$ = "Archivo win.ini o entrada sShortDate no encontrados."
        '    MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
        '    Exit Function
        'End If
    
        'VTFormatoFecha$ = Mid$(VTFormatoFecha$, 1, VTRetval%)
        'If VTFormatoFecha$ <> VTFechaPref$ Then VTProblema% = True
        VTFormatoFecha$ = FMGetFormatoFecha()
        If VTFormatoFecha$ = "" Then
            VTMsg$ = "Archivo win.ini o entrada sShortDate no encontrados."
            MsgBox VTMsg$, 16, "ERROR - FMVerificar_WinIni"
        Exit Function
        End If
        If VTFormatoFecha$ <> VTFechaPref$ Then VTProblema% = True
    
    'Si hay error en entradas del win.ini
    If VTProblema% Then
        VTProblema% = False
        VTMsg$ = "La configuración para números y fechas del Panel de Control de Windows es "
        VTMsg$ = VTMsg$ + "incompatible con las preferencias de COBIS - Personalización." + Chr$(13)
        VTMsg$ = VTMsg$ + Chr$(13) + "La configuración internacional del Panel de Control "
        VTMsg$ = VTMsg$ + "debe ser modificada." + Chr$(13)
        VTMsg$ = VTMsg$ + Chr$(13) + "Separador de miles : , "
        VTMsg$ = VTMsg$ + Chr$(13) + "Separador de decimales : . "
        VTMsg$ = VTMsg$ + Chr$(13) + "Formato de fecha : " + VTFechaPref$
        MsgBox VTMsg$, 48, "ERROR - Tesorería"
        VTProblema% = True
    End If
    FMVerificar_WinIni = Not VTProblema%
End Function

Sub PMCatalogo(tipo As String, Tabla As String, ObjetoA As Object, ObjetoB As Object)
    Select Case tipo$
    Case "A"
        VGPaso% = True
        'GBB26May98008 II:
        'Se debe hacer un load a la forma antes de cargar los valores
        Load FRegistros
        'GBB26May98008 IF:
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, Tabla$
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            FRegistros.Show 1
            ObjetoA.Text = VGACatalogo.Codigo$
'FIXIT: 'Caption' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Caption' declare 'ObjetoB' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            ObjetoB.Caption = VGACatalogo.Descripcion$
        End If
    Case "V"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, Tabla$
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (ObjetoA.Text)
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & ObjetoA.Text & "]") Then
             PMMapeaObjeto sqlconn&, ObjetoB
             PMChequea sqlconn&
        Else
            VGPaso% = True
            ObjetoA.Text = ""
'FIXIT: 'Caption' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Caption' declare 'ObjetoB' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            ObjetoB.Caption = ""
        End If
    Case "D"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, Tabla$
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
             PMMapeaObjetoAB sqlconn&, ObjetoA, ObjetoB
             PMChequea sqlconn&
        Else
            ObjetoA.Text = ""
'FIXIT: 'Caption' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Caption' declare 'ObjetoB' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            ObjetoB.Caption = ""
        End If
    End Select
End Sub

Sub PMLimpiaGrid(grdGrid As Object)
Dim i%
Dim j%
'FIXIT: 'Rows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Rows' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.Rows = 2
'FIXIT: 'Cols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Cols' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.Cols = 2
    For i% = 0 To 1
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        grdGrid.Col = i%
        For j% = 0 To 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            grdGrid.Row = j%
            grdGrid.Text = ""
        Next j%
    Next i%
'FIXIT: 'ColWidth(0' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ColWidth(0' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.ColWidth(0) = 480
'FIXIT: 'ColWidth(1' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ColWidth(1' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.ColWidth(1) = 480
End Sub

Sub PMLogOff()
Dim LoginVG$
Dim VTTemporal$
    VGCorreo% = False
     PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "1502"
     PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
     PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, LoginVG$
     If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
         PMMapeaVariable sqlconn&, VTTemporal$
         PMChequea sqlconn&
        FPrincipal.lblEtiqueta.Visible = False
        FPrincipal.cmbFilial.Visible = False
        Escribir_Ini ARCHIVOINI
        MsgBox "OK...  Desconexión del Servidor: " + ServerName$, 0, "Mensaje del Servidor"
        
        SqlExit
        SqlWinExit
         sqlconn& = 0
        FPrincipal.mnuLogon.Enabled = True
        FPrincipal.mnuLogoff.Enabled = False
        FPrincipal.mnuCambioPass.Enabled = False
        
        FPrincipal.mnuProductos.Enabled = False
        FPrincipal.mnuServicios.Enabled = False
        FPrincipal.mnuRango.Enabled = False
        FPrincipal.mnuCostos.Enabled = False
        FPrincipal.mnuContenido.Enabled = False
        FPrincipal.mnuBloquear.Enabled = False
    Else
        MsgBox "El usuario no se pudo desconectar del servidor", 0, "Mensaje del Servidor"
    End If

End Sub

Sub PMAnchoColGrid(lista1 As Object, Col As Integer)
'****************************************************************
' Objetivo: Procedimiento que permite ajustar el ancho de
'           la columna de una grilla al máximo numero de
'           caracteres que tenga cada fila de la misma
' Input   : La grid, el valor minimo que tomará si no existieran
'           datos (en caracteres) y la columna a ajustar
'****************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 09-Sep-99      R. Amarís       Emision Inicial
'****************************************************************
Dim VTColmax As Integer
Dim i%
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'lista1' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    lista1.Col = Col
    VTColmax = 5
'FIXIT: 'Rows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Rows' declare 'lista1' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    For i% = 0 To lista1.Rows - 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'lista1' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        lista1.Row = i%
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
        If Len(RTrim$(lista1.Text)) > VTColmax Then
            VTColmax = Len(lista1.Text)
        End If
    Next i%
    VTColmax = VTColmax * 110   '110 es el valor promedio de twips por caracter font: small font 6.25
'FIXIT: 'ColWidth(Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ColWidth(Col' declare 'lista1' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    lista1.ColWidth(Col) = VTColmax
End Sub

'****************************************************
'CloVargas Oct/19/01 Añado esta funcion para manejo
'      de codigo fecha y string Ej.101 , mm/dd/yyyy
'****************************************************
Sub PMCargar_FechaSP(Formato As String)
Dim i%
Dim VGFecha_Pref$
    For i% = 1 To UBound(formato_fecha)
        If formato_fecha(i%, 1) = Formato$ Then
           VGFecha_SP$ = formato_fecha(i%, 2)
           VGFecha_Pref$ = Formato$
        End If
    Next
End Sub

Public Sub PMDireccionPath()
On Error GoTo error
Dim cp As CopiaDir.CopiaDirectorios
Set cp = New CopiaDir.CopiaDirectorios
PathUnico = cp.CreaDirectorios(App.Path, App.EXEName, "PERSON.INI")
If PathUnico = "" Then
   PathUnico = VGPath$
End If
Exit Sub
error:
    MsgBox "Error: " + Err.Description, , "Atención"
    PathUnico = App.Path
End Sub




