Attribute VB_Name = "MODSYS"
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'**************************************************************
'   ARCHIVO:        MODSYS.BAS
'   NOMBRE LOGICO:  MODSYS
'   PRODUCTO:       General
'**************************************************************
'                        IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios propiedad
' de MACOSA, representantes exclusivos para  el Ecuador de  la
' NCR CORPORATION.  Su uso  no  autorizado queda  expresamente
' prohibido así como cualquier alteración o agregado hecho por
' alguno  de sus  usuarios  sin el debido  consentimiento  por
' escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su
' representante
'*************************************************************
'                         PROPOSITO
' Este módulo contiene las rutinas necesarias para consultar
' datos del Registry de Windows tales como: nombre computador,
' formato de fecha, etc. Estas funciones deben reemplazar a
' las empleadas para leer los archivos "INI" de las verisones
' anteriores de windows
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
'*************************************************************

Option Explicit

Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, ByRef phkResult As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, ByRef lpType As Long, ByVal lpData As String, ByRef lpcbData As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal parDirectory As String, ByVal parSize As Integer) As Integer
Private Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Integer, ByVal uParam As Integer, ByVal lpvParam As String, ByVal fuWinIni As Integer) As Integer
Declare Function GetLocaleInfo Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Long, ByVal LCType As Long, ByVal lpLCData As String, ByVal cchData As Long) As Long

Public Declare Function NombreCliente Lib "def2.dll" Alias "NombreClienteA" (ByVal Nombre1 As String, ByVal Nombre2 As String) As Boolean

Global Const CG_HKEY_LOCAL_MACHINE = &H80000002


Public Function FMGetComputerName() As String
'*************************************************************
' Objetivo:  Obtiene el nombre del computador
' Input   :  Ninguno
' Output  :  FMGetComputerName
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
'*************************************************************
  
    Dim VTComputerName As String
    
    If FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName", "ComputerName", VTComputerName$) Then
        FMGetComputerName = VTComputerName$
    Else
        FMGetComputerName = ""
    End If
End Function
Public Function FMGetSeparadorMiles() As String
'*************************************************************
' Objetivo:  Obtiene el seperador de miles
' Input   :  Ninguno
' Output  :  FMGetSeparadorMiles
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
' 25/Nov/98      J.Altamirano    Modificación
'*************************************************************

    Dim VTSeparadorMiles As String * 2
    Dim VTRet As Long
    VTRet = GetLocaleInfo(1024, 15, VTSeparadorMiles$, 2)
    
    If VTRet > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
      FMGetSeparadorMiles = Mid$(VTSeparadorMiles$, 1, 1)
    Else
      FMGetSeparadorMiles = ""
    End If
    
End Function


Public Function FMGetSeparadorDecimales() As String
'*************************************************************
' Objetivo:  Obtiene el seperador de decimales
' Input   :  Ninguno
' Output  :  FMGetSeparadorDecimales
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
' 25/Nov/98      J.Altamirano    Modificación
'*************************************************************
    
    Dim VTSeparadorDecimales As String * 2
    Dim VTRet As Long
    VTRet = GetLocaleInfo(1024, 14, VTSeparadorDecimales$, 2)
    
    If VTRet > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
      FMGetSeparadorDecimales = Mid$(VTSeparadorDecimales$, 1, 1)
    Else
      FMGetSeparadorDecimales = ""
    End If
    
End Function

Public Function FMGetFormatoFecha() As String
'*************************************************************
' Objetivo:  Obtiene el formato de fecha de windows
' Input   :  Ninguno
' Output  :  FMGetFormatoFecha
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
' 25/Nov/98      J.Altamirano    Modificación
'*************************************************************
  
    Dim VTFormatoFecha As String * 11
    Dim VTRet As Long
    VTRet = GetLocaleInfo(1024, 31, VTFormatoFecha$, 11)
    
    If VTRet > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
      FMGetFormatoFecha = Mid$(VTFormatoFecha$, 1, VTRet - 1)
    Else
      FMGetFormatoFecha = ""
    End If
End Function


Function FMObtenerSeccionToken(parSeccion As String, parToken As String, parPath As String) As String
'*************************************************************
' Objetivo:  Obtiene el valor de un token dentro de un
'            archivo "INI"
' Input   :  parSeccion             'nombre de la sección
'            parToken               'nombre de la clave
'            parPath                'path completo del archivo
' Output  :  FMObtenerSeccionToken  'valor
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
'*************************************************************

    Dim VTNum As Integer
    Dim VTRegistro As String
    Dim VTFlag As Integer
  
    On Error GoTo ERRORARCHIVOINI
    VTNum = FreeFile
    Open parPath$ For Input As #VTNum
    VTFlag% = False
    While Not EOF(VTNum%)
        Line Input #VTNum%, VTRegistro$
        If VTFlag% Then
            If InStr(1, VTRegistro, parToken, 1) > 0 Then
                FMObtenerSeccionToken = Mid$(VTRegistro$, InStr(1, VTRegistro$, "=") + 1, Len(VTRegistro$) - InStr(1, VTRegistro$, "="))
                Close VTNum%
                Exit Function
            End If
        End If
        
        If InStr(1, VTRegistro, parSeccion, 1) > 0 Then
            VTFlag% = True
        End If
    Wend
    
    Close #VTNum%
    FMObtenerSeccionToken$ = ""
    Exit Function
    
ERRORARCHIVOINI:
  FMObtenerSeccionToken$ = ""
End Function

Public Function FMGetKeyValue(parKeyRoot As Long, parKeyName As String, parSubKeyRef As String, ByRef parKeyVal As String) As Boolean
'*************************************************************
' Objetivo:  Obtiene el valor de una clave en el Registry
'            de windows
' Input   :  KeyRoot        'Inicio de Búsqueda
'            KeyName        'Nombre de la clave
'            SubKeyRef      'Referencia de la clave
' Output  :  FMGetKeyValue  'True / False
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
'*************************************************************
    
    Const CT_SUCCESS = 0
    Const CT_REG_SZ = 1
    Const CT_REG_DWORD = 4
    Const CT_KEY_QUERY_VALUE = &H1

    Dim vti As Long                 ' Contador
    Dim VTrc As Long                ' Código de retorno
    Dim VThKey As Long              ' Manipulador de clave de registro abierta
    Dim VTKeyValType As Long        ' Tipo de dato de una clave de registro
    Dim VTtmpVal As String          ' Almacenamiento temporal del valor de una clave de registro
    Dim VTKeyValSize As Long        ' Tamaño de la variable de registro
    
    '------------------------------------------------------------
    ' Abrir RegKey bajo KeyRoot {CG_HKEY_LOCAL_MACHINE...}
    '------------------------------------------------------------
    VTrc = RegOpenKeyEx(parKeyRoot, parKeyName, 0, CT_KEY_QUERY_VALUE, VThKey)    ' Abrir Registry Key
    If (VTrc <> CT_SUCCESS) Then
        GoTo BuscarClaveError                                           ' Manejo de Error...
    End If
    
    VTtmpVal = String$(1024, 0)                                         ' Redimencionar variable
    VTKeyValSize = 1024                                                 ' Marcar tamaño de la variable
    
    '------------------------------------------------------------
    ' Recuperar el valor del Registry Key
    '------------------------------------------------------------
    VTrc = RegQueryValueEx(VThKey, parSubKeyRef, 0, VTKeyValType, VTtmpVal, VTKeyValSize)          ' Buscar/Crear el Key Value
                        
    If (VTrc <> CT_SUCCESS) Then
        GoTo BuscarClaveError                                           ' Manejo de Error...
    End If
    
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    If (Asc(Mid$(VTtmpVal, VTKeyValSize, 1)) = 0) Then                   ' Win95: String de terminación nulo
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTtmpVal = Left$(VTtmpVal, VTKeyValSize - 1)                     ' No encontrado, Extraer del string
    Else                                                                ' WinNT: No existe string de terminación nulo
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTtmpVal = Left$(VTtmpVal, VTKeyValSize)                         ' No existe NULL, Extraer string solamente
    End If
    
    '------------------------------------------------------------
    ' Determinar el tipo del Key Value Type para conversión
    '------------------------------------------------------------
    Select Case VTKeyValType                                            ' Buscar tipo de dato
        Case CT_REG_SZ                                                  ' Tipo de dato String
            parKeyVal = VTtmpVal                                        ' Copiar valor del string
        Case CT_REG_DWORD                                               ' Tipo de dato Double
            For vti = Len(VTtmpVal) To 1 Step -1                        ' Convertir cada Bit
'FIXIT: Replace 'Hex' function with 'Hex$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                parKeyVal = parKeyVal + Hex$(Asc(Mid$(VTtmpVal, vti, 1))) ' Construir valor Char. Caracter por caracter
            Next
            parKeyVal = Format$("&h" + parKeyVal)                       ' Convertir Double Word a String
    End Select
    
    FMGetKeyValue = True                                                ' Retorno exitoso
    VTrc = RegCloseKey(VThKey)                                          ' Cerrar el Registry Key
    Exit Function                                                       ' Salir
    
BuscarClaveError:                   ' Limpiar después de que el error ocurre
    parKeyVal = ""                  ' Valor de retorno = String nulo
    FMGetKeyValue = False           ' Retorno fallido
    VTrc = RegCloseKey(VThKey)      ' Cerrar el Registry Key
End Function

Public Function FMGetSystemDirectory() As String
'*************************************************************
' Objetivo:  Obtiene el el directorio del sistema de
'            windows
' Input   :  Ninguno
' Output  :  FMGetSystemDirectory
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21/Nov/97      J.Bucheli       Emision Inicial
'*************************************************************

    Dim VTSystemDirectory As String * 255
    Dim VTSize As Long
    
     
    VTSize& = 255
    VTSize& = GetSystemDirectory(VTSystemDirectory$, VTSize&)
    If VTSize& > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        FMGetSystemDirectory = Mid$(VTSystemDirectory$, 1, VTSize&)
    Else
        FMGetSystemDirectory = ""
    End If
End Function

