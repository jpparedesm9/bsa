Attribute VB_Name = "ModImprimir"
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          ModImprimir.bas
' NOMBRE LOGICO:    ModImprimir
' PRODUCTO:         SERVICIOS BANCARIOS
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Este módulo contiene las funciones y procedimientos que serán
' utilizados para realizar impresiones
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 11-Dic-98      Ana M.López     Emision Inicial
'*************************************************************

Option Explicit

Global Const CG_RIGHT_ALIGN As Integer = 1
Global Const CG_CENTER_ALIGN As Integer = 0
Global Const CG_LEFT_ALIGN As Integer = -1
Global Const CG_PORTRAIT% = 1       'Vertival
Global Const CG_LANDSCAPE% = 2      'Horizontal


Private Function FLToken_Parameter(parCad As String, parToken As String) As Long
'*************************************************************
' PROPOSITO: Elimina el token parToken##  encontrado en parCad,
'            y retorna  ##. Este Procedimiento es llamada desde
'            PMRead_File y PLPrint_String.
' INPUT    : parCad: Cadena a la que va a reemplazar el token
'            parToken : Token a reemplazarse
' OUTPUT   : Todos los parámetros de input son pasados por
'            referencia. Al interior de este procedimiento se
'            modifica parCad.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Oct-1997    M.del Pozo      Emisión Inicial
' 11-Dic-98      Ana M.López     Estandarización
'*************************************************************

    Dim VTpos As Long         'Posición donde se encuentra el token
    Dim VTchar As String      'Caracter temporal
    Dim VTIndice As String    'Valor ## del token parToken
    Dim VTcont As Long        'Contador temporal
    
    VTpos& = InStr(parCad$, parToken$)
    If VTpos& > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VTchar$ = Mid$(parCad$, VTpos& + Len(parToken$), 1)
        VTcont& = 1
        VTIndice$ = ""
        Do While IsNumeric(VTchar$)
            VTIndice$ = VTIndice$ + VTchar$
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VTchar$ = Mid$(parCad$, VTpos& + Len(parToken$) + VTcont&, 1)
            VTcont& = VTcont& + 1
        Loop
        
        If IsNumeric(VTIndice$) Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
            parCad$ = LTrim$(Left$(parCad$, VTpos& - 1) + Mid$(parCad$, VTpos& + Len(parToken$) + VTcont& - 1))
            FLToken_Parameter = CLng(VTIndice$)
            Exit Function
        End If
    End If
    
    FLToken_Parameter = -1
End Function

Private Sub PLReplace_Fields(parCad As String, parDatos() As String)
'*************************************************************
' PROPOSITO: Reemplaza todos los tokens \Field## encontrados en
'            parCad, por el correspondiente dato de parDatos(##)
'            Este Procedimiento es llamada desde PLRead_File.
' INPUT    : parCad: Cadena donde se reemplazarán lod tokens
'            parDatos(): Arreglo de datos que van a reemplazar
'            los tokens \Field'
' OUTPUT   : Todos los parámetros de input son pasados por refe-
'            rencia. Al interior de este procedimiento se modi-
'            fica parCad
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Oct-1997    M.del Pozo      Emisión Inicial
' 11-Dic-98      Ana M.López     Estandarización
'*************************************************************

    Dim VTpos As Long             'Posición donde se encuentra un token \Field
    Dim VTNumDatos As Long        'Tamaño del vector parDatos()
    Dim VTDiferencia As Long      'Número de caracteres a quitar por el token \Field##
    Dim VTIndice As String        'Parametro(##) del token \Field##
    Dim VTcont As Long            'Contador temporal
    Dim VTchar As String          'Caracter temporal
    Dim VTValor As String         'Valor obtenido de parDatos(##)
    Dim VTRet As Integer          'Valor de retorno del mensaje de error
    Dim VTMensaje As String       'Mensaje de error
    Dim VTPosMaxLong As Long      'Posición donde se encuentra un token \MaxLong
    Dim VTCad_Tmp As String       'Cadena temporal donde se almacena parCad
    Dim VTMaxLong As Long         'Longitud máxima de un campo field
    
    


    
    VTNumDatos& = UBound(parDatos$, 1)
    VTDiferencia& = 0
    
    If VTNumDatos& > 0 Then
        VTpos& = InStr(parCad$, "\Field")
        Do While VTpos& > 0
            VTDiferencia& = 6
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VTchar$ = Mid$(parCad$, VTpos& + 6, 1)
            VTcont& = 1
            VTIndice$ = ""
            If IsNumeric(VTchar$) Then
                Do While VTchar$ <> " "
                    VTIndice$ = VTIndice$ + VTchar$
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                    VTchar$ = Mid$(parCad$, VTpos& + 6 + VTcont&, 1)
                    If Not IsNumeric(VTchar$) Then VTchar$ = " "
                    VTcont& = VTcont& + 1
                Loop
            End If
    
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If IsNumeric(Trim$(VTIndice$)) Then
                If CLng(VTIndice$) <= VTNumDatos& Then
                    'Longitud de \Field  mas los numeros de campo
                    VTDiferencia& = VTDiferencia& + (VTcont& - 1)
                    VTValor$ = parDatos$(CLng(VTIndice$))
                    VTCad_Tmp$ = parCad$
                    'Si el dato debe ser configurado con longitud máxima
                    VTMaxLong& = FLToken_Parameter(VTCad_Tmp$, "\MaxLong")
                    If (InStr(parCad$, "\MaxLong") + Len(CStr(VTMaxLong&)) + 9) = VTpos& Then
                        VTPosMaxLong& = InStr(parCad$, "\MaxLong")
                        If VTPosMaxLong& > 0 Then
                           'Se utiliza VTCad_Tmp porque se pasa a FLToken_Parameter por referencia
                           VTCad_Tmp$ = parCad$
                           VTMaxLong& = FLToken_Parameter(VTCad_Tmp$, "\MaxLong")
                           If VTMaxLong& <= Len(VTValor$) Then
                               'Truncar la cadena, longitud máxima = VTMaxLong
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTPosMaxLong& - 1) + Mid$(parCad$, VTPosMaxLong& + Len("\MaxLong" + CStr(VTMaxLong&)))
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                               VTValor$ = Left$(VTValor$, VTMaxLong&)
                               VTpos& = InStr(parCad$, "\Field")
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTpos& - 1) + VTValor$ + Mid$(parCad$, VTpos& + VTDiferencia&)
                           Else
                               'Poner espacios en blanco luego del Field reemplazado hasta completar VTMaxLong
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTPosMaxLong& - 1) + Mid$(parCad$, VTPosMaxLong& + Len("\MaxLong" + CStr(VTMaxLong&)))
                               VTValor$ = VTValor$ + Space(VTMaxLong& - Len(VTValor$))
                               VTpos& = InStr(parCad$, "\Field")
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTpos& - 1) + VTValor$ + Mid$(parCad$, VTpos& + VTDiferencia&)
                           End If
                        End If
                    Else
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                        parCad$ = Left$(parCad$, VTpos& - 1) + VTValor$ + Mid$(parCad$, VTpos& + VTDiferencia&)
                    End If
                Else
                    VTMensaje$ = FMResolveResString(15128, "|1", VTIndice$)
                    VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
                    Exit Sub
                End If
            End If
            VTpos& = VTpos& + VTDiferencia&
            VTpos& = InStr(VTpos&, parCad$, "\Field")
        Loop
    End If
    
    'Si existen más campos que llenar y menos datos en el arreglo
    If VTNumDatos < Val(VTIndice$) Then
        VTRet% = FMMsgBox(15129, vbCritical, 15000, "", "")
        Exit Sub
    End If
End Sub

Private Sub PLPrint_String(parCad As String, parX As Single, parY As Single, parHBorder As Single, parVBorder As Single, parFBold As Integer, parFUnderline As Integer, parFSize As Long)
'**************************************************************
' PROPOSITO: Imprimir una cadena de manera justificada
'            Este Procedimiento es llamado desde PLApply_Tokens
' INPUT    : parCad     Cadena a la que se va a imprimir.
'            parx       Posición Horizontal (mm) a partir de la
'                       que se quiere iniciar la impresión
'            pary       Posición Vertical (mm)a partir de la que
'                       se quiere iniciar la impresión
'            parHBorder     Borde Horizontal a aplicarse
'            parVBorder     Borde Vertical a aplicarse
'            parFBold       Indica si se va a imprimir en Bold
'            parFUnderline  Indica si se va a imprimir en Underline
'            parFSize       Tamaño de letra de impresión
' OUTPUT   : Todos los parámetros de input son pasados por refe-
'            rencia.  Al interior de este procedimiento se mo-
'            difican Cad, x e y.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Oct-1997    M.del Pozo      Emisión Inicial
' 11-Dic-98      Ana M.López     Estandarización
'*************************************************************

    Dim VTAux As String          'Subcadena de longitud lon
    Dim VTcaracter As String     'ultimo Caracter  de aux
    Dim VTSitio As Integer       'Sitio de cad desde donde se toma el nuevo cad
    Dim VTVeces As Integer       'Numero de Veces que hay que insertar espacios
    Dim VTpos As Integer         'posicion en la que se encuentra un espacio para aumentar otro espacio
    Dim vti As Integer           'sitio desde el cual se busca un nuevo espacio
    Dim VTpasada As Integer      'Número de veces que ha pasado la cadena aux para ser completada con espacios
    Dim VTAncho As Single        'Ancho de la hoja
    Dim VTAlto As Single         'Alto de la Hoja

'Sitio donde hay una nueva linea
    Dim VTLon_Aux As Integer     'Longitud auxiliar del ancho de una linea
    Dim VTPIntermedio As Integer 'Indica si se debe imprimir desde un sitio que no sea el borde horizontal.
    Dim VTNLineas As Integer     'No. de líneas impresas
    Dim VTLon As Integer         'Longitud del ancho de la página
    
    Printer.CurrentY = parY!
    Printer.FontBold = parFBold%
    Printer.FontUnderline = parFUnderline%
    Printer.FontSize = parFSize&
    Printer.DrawWidth = 10
    
    VTAncho! = Printer.ScaleWidth - 1 - 2 * parHBorder!
    VTAlto! = Printer.ScaleHeight - 1 - 2 * parVBorder!
    
    VTLon_Aux% = 0
    VTPIntermedio% = 0
    VTNLineas% = 0
    
    'Si la cadena se debe empezar a escribir desde una posición diferente del borde Horizontal
    If parX! > parHBorder! Then
        vti% = 1
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
        Do While Printer.TextWidth(String$(vti%, 32)) <= (parHBorder! + VTAncho! - parX!)
            vti% = vti% + 1
        Loop
        VTPIntermedio% = 1
        VTLon_Aux% = vti% - 1
        Printer.CurrentX = parX!
    Else
        Printer.CurrentX = parHBorder!
    End If
    
    'Determinar el número de caracteres que se requieren para completar el ancho de la hoja
    vti% = 1
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
    Do While Printer.TextWidth(String$(vti%, 32)) <= VTAncho!
        vti% = vti% + 1
    Loop
    
    'Si se tiene que empezar a escribir desde el borde
    If VTPIntermedio% = 0 Then
        VTLon% = vti% - 1
    Else
        VTLon% = VTLon_Aux%
        VTLon_Aux% = vti% - 1
    End If
    
    If Len(parCad$) > VTLon% Then
        Do While Len(parCad$) > VTLon%
            VTSitio% = VTLon% + 1
            VTcaracter$ = Mid$(parCad$, VTSitio%, 1)
        
            Do While VTcaracter$ <> " "
                 If VTSitio% > 1 Then
                    VTSitio% = VTSitio% - 1
                    VTcaracter$ = Mid$(parCad$, VTSitio%, 1)
                End If
                If VTcaracter$ = Chr$(13) Then
                    VTcaracter$ = " "
                End If
            Loop
           
            VTVeces% = VTLon% - (VTSitio% - 1)
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
            VTAux$ = Left$(parCad$, VTSitio% - 1)
            
            vti% = 1
            VTpasada% = 1
            Do While VTVeces% > 0
                VTpos% = InStr(vti%, VTAux$, " ")
                If VTpos% > 0 Then
                   VTAux$ = Left$(VTAux$, VTpos% - 1) + Space$(VTpasada% + 1) + Mid$(VTAux$, VTpos% + VTpasada%)
                   vti% = VTpos% + VTpasada% + 1
                   VTVeces% = VTVeces% - 1
                Else
                    If VTpasada% = 1 And VTVeces% = (VTLon% - (VTSitio% - 1)) Then     'Si no hay ningun espacio se trunca LA CADENA
                        VTSitio% = VTLon%
                        VTAux$ = Left$(parCad$, VTSitio%)
                        VTVeces% = 0
                    Else
                        vti% = 1
                        VTpasada% = VTpasada% + 1
                    End If
                End If
            Loop
            
            parCad$ = Mid$(parCad$, VTSitio% + 1)
            
            If (Printer.CurrentY + Printer.TextHeight(" ")) > (parVBorder! + VTAlto!) Then
                Printer.NewPage
                Printer.CurrentX = parHBorder!
                Printer.CurrentY = parVBorder!
            End If
            
            Printer.Print VTAux$
            
            VTNLineas% = VTNLineas% + 1
            
            If VTPIntermedio% <> 0 Then VTLon% = VTLon_Aux%
            
            Printer.CurrentX = parHBorder!
        Loop
    End If
    
    If VTNLineas% > 0 Then
        Printer.CurrentX = parHBorder!
    Else
        Printer.CurrentX = parX!
    End If
    
     If (Printer.CurrentY + Printer.TextHeight(" ")) > (parVBorder! + VTAlto!) Then
        Printer.NewPage
        Printer.CurrentX = parHBorder!
        Printer.CurrentY = parVBorder!
     End If
    
    Printer.Print parCad$;
    parY! = Printer.CurrentY
    parX! = Printer.CurrentX
End Sub

Private Sub PLApply_Tokens(parCad As String, parX As Single, parY As Single, parHBorder As Single, parVBorder As Single, parFontSize As Long, parTitleSize As Long)
'*************************************************************
' PROPOSITO: Interpretar los tokens embebidos en una  cadena a
'            imprimirse. Este Procedimiento es  llamado  desde
'            PMRead_File.
' INPUT    : parCad         Cadena a la que se va a interpretar
'                           los tokens.
'            parx           Posición (mm)Horizontal a partir de
'                           la cual se iniciará la impresión.
'            pary           Posición (mm) Vertical a partir de
'                           la cual se iniciará la impresión.
'            parHBorder     Borde Horizontal a aplicarse.
'            parVBorder     Borde Vertical a aplicarse.
'            parFontSize    Tamaño de la letra normal(no Títulos)
'            parTitleSize   Tamaño de la letra para los títulos.
' OUTPUT   : Todos los parámetros de input son pasados por refe-
'            rencia. Al interior de este procedimiento se modi-
'            fican parCad, x e y.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Oct-1997    M.del Pozo      Emisión Inicial
' 11-Dic-98      Ana M.López     Estandarización
'*************************************************************

    Dim VTFBold As Integer        'Indica si se va a imprimir en Bold
    Dim VTFUnderline As Integer   'Indica si se va a imprimir en Underline
    Dim VTToken As String         'Almacena un Token leido desde parCad
    Dim VTchar As String          'Almacena un caracter leido desde parCad
    Dim VTpos1 As Long            'Posición donde se encuentra inicio de Token {\
    Dim VTPos2 As Long            'Posición donde se encuentra Fin de Token \}
    Dim VTCad_Aux As String       'Cadena contenidad entre {\  y  \}
    Dim VTPosBold As Long         'Posicion donde se encuentra token de Bold
    Dim VTPosUndl As Long         'Posicion donde se encuentra token de Underline


    Dim VTFSize As Long           'Almacena Tamaño de letra a utilizar en impresión
    Dim VTCad_Tmp As String       'Cadena temporal
    Dim VTValor As Long           'Valor recuperado desde un token
    Dim VTPosSpce As Long         'Posicion donde se encuentra token de Espacio
    Dim VTRet As Integer          'Valor de retorno del mensaje de error
    
    VTToken$ = ""
    VTchar$ = "\"
    VTFSize& = parFontSize&
    VTpos1& = InStr(parCad$, "{\")
    
    Do While VTpos1& > 0
        VTFBold% = False
        VTFUnderline% = False
        VTPos2& = InStr(VTpos1&, parCad$, "\}")
        If VTPos2& = 0 Then
            VTRet% = FMMsgBox(15129, vbCritical, 15000, "", "")
            Exit Sub
        End If
    
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTCad_Aux$ = Left$(parCad$, VTpos1& - 1)
        If Len(VTCad_Aux$) > 0 Then PLPrint_String VTCad_Aux$, parX!, parY!, parHBorder!, parVBorder!, VTFBold%, VTFUnderline%, VTFSize&
        
        VTCad_Aux$ = Mid$(parCad$, VTpos1& + 1, VTPos2& - (VTpos1& + 1))
        If Len(VTCad_Aux$) > 0 Then
             VTPosBold& = InStr(VTCad_Aux$, "\FontBold")
             If VTPosBold& > 0 Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                VTCad_Aux$ = LTrim$(Left$(VTCad_Aux$, VTPosBold& - 1) + Mid$(VTCad_Aux$, VTPosBold& + Len("\FontBold")))
                VTFBold% = True
             End If
             
             VTPosUndl& = InStr(VTCad_Aux$, "\FontUnderline")
             If VTPosUndl& > 0 Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                VTCad_Aux$ = LTrim$(Left$(VTCad_Aux$, VTPosUndl& - 1) + Mid$(VTCad_Aux$, VTPosUndl& + Len("\FontUnderline")))
                VTFUnderline% = True
             End If
             
             VTPosUndl& = InStr(VTCad_Aux$, "\Title")
             If VTPosUndl& > 0 Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                VTCad_Aux$ = LTrim$(Left$(VTCad_Aux$, VTPosUndl& - 1) + Mid$(VTCad_Aux$, VTPosUndl& + Len("\Title")))
                VTFSize& = parTitleSize&
             End If
    
             VTPosSpce& = InStr(VTCad_Aux$, "\Space")
             If VTPosSpce& > 0 Then
                'Se utiliza VTCad_Tmp porque se pasa a FLToken_Parameter por referencia
                VTCad_Tmp$ = VTCad_Aux$
                VTValor& = FLToken_Parameter(VTCad_Tmp$, "\Space")
                If VTValor& <> -1 Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                    VTCad_Aux$ = LTrim$(Left$(VTCad_Aux$, VTPosSpce& - 1)) + Space$(VTValor&) + Mid$(VTCad_Aux$, VTPosSpce& + Len("\Space" + CStr(VTValor&)))
                End If
             End If
                     
            PLPrint_String VTCad_Aux$, parX!, parY!, parHBorder!, parVBorder!, VTFBold%, VTFUnderline%, VTFSize&
        End If
        
        parCad$ = Mid$(parCad$, VTPos2& + 2)
        VTpos1& = 0
        If Len(parCad$) Then VTpos1& = InStr(parCad$, "{\")
    Loop
    
    VTFBold% = False
    VTFUnderline% = False
    If Len(parCad$) > 0 Then
        PLPrint_String parCad$, parX!, parY!, parHBorder!, parVBorder!, VTFBold%, VTFUnderline%, VTFSize&
    End If
End Sub


'FIXIT: Declare 'parGrid' and 'parColumnas' and 'parSepColumnas' and 'parCaptionSubTitulos' and 'parValuesSubTitulos' and 'parAlineacion' and 'parOrientacion' with an early-bound data type     FixIT90210ae-R1672-R1B8ZE
Public Sub PMImprimirReporte(parGrid As Object, parNColumnas As Integer, parColumnas() As Integer, parSepColumnas() As Integer, parTitulo As Integer, parCaptionSubTitulos() As Integer, parValuesSubTitulos() As String, parAlineacion() As Integer, Optional parOrientacion As Integer = CG_PORTRAIT%)
'*************************************************************
'PROPOSITO: Realizar la impresión de reportes utilizando un
'            objeto de la clase PrinterDll.Report (printerDll.dll)
' INPUT    : parGrid              Grid que que se va a imprimir
'            parNColumnas         Número de columnas a imprimir
'            parColumnas          Contiene los índices de las columnas a imprimir
'            parSepColumnas       Contiene las separaciones entre columnas (en caracteres)
'            parTitulo            Contiene el número de recurso del título
'            parCaptionSubTitulos Contiene los números de recurso de las etiquetas de los subtítulos
'            parValuesSubTitulos  Contiene los valores que se desplegarán en los subtítulos (strings)
'            parAlineacion        Arreglo que contiene la alineación de las columnas, si su dimensión es 0 toma como default la alineación a la izq.
'            parOrientacion       Contiene la orientacion de la impresion, Vertical, Horizontal
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 22-Dic-98      X. Ramos       Emision Inicial
'*************************************************************
    
    Dim VTReport As PrinterDll.Report
    Dim vti As Integer
    Dim VTRet As Integer
    Dim VTUnidad As Integer 'xrs: 22-09-99
      
    VTUnidad = Printer.ScaleMode    'xrs: 22-09-99
    
    'Verificación de existencia de registros en el grid
    If parGrid.MaxRows = 0 Then
        VTRet% = FMMsgBox(15155, vbExclamation, 15001, "", "")
        Exit Sub
    End If
    
    'Creación del Objeto Report
    Set VTReport = New PrinterDll.Report
    
    'Printer.ScaleMode = vbCharacters    'xrs: 22-09-99
    Printer.ScaleMode = vbCentimeters    'xrs: 21-11-99
    
    'Definición de atributos del Título
    VTReport.FMSetTitleAlign CG_CENTER_ALIGN%
    VTReport.FMSetTitleFont "Courier"
    VTReport.FMSetTitleFontBold True
    VTReport.FMSetTitleCaption LoadResString(parTitulo)
    VTReport.FMSetTitleInEachPage True
    
    'Definición de Atributos para los subtítulos
    VTReport.FMSetHeaderPageNumbers True
    VTReport.FMSetHeaderAlign CG_LEFT_ALIGN%
    VTReport.FMSetHeaderFontBold False
    VTReport.FMSetHeaderInEachPage True
    VTReport.FMSetHeaderShowDate True
    
    'Definicion de Caption y Value de cada Subtítulo
    VTReport.FMSetHeaderNSubTitles UBound(parCaptionSubTitulos) + 1 'Número de Subtítulos
    For vti% = 0 To UBound(parCaptionSubTitulos)
        VTReport.FMPutHeaderSubtitle vti%, LoadResString(Val(parCaptionSubTitulos(vti%))), CStr(parValuesSubTitulos(vti%))
    Next vti%
    
    
    'DEFINICION DE DETAIL
    'Tamaño de letra del detalle del reporte
    VTReport.FMSetDetailSize (7)
    
    'Número de columnas de impresión
    VTReport.FMSetReportNColumns parNColumnas
    
    'Carga de los parámetros y valores del grid a imprimir
    VTReport.PMLoad_Parameters parGrid
        
    'xrs: 12-10-99 UI, Alineación de las columnas.
    If UBound(parAlineacion) = 0 Then
        'Indices de las columnas a imprimir, tamaño en caracteres para cada columna,
        For vti% = 0 To parNColumnas - 1
            VTReport.PMPutColumn vti%, Val(parColumnas(vti%)), Val(parSepColumnas(vti%)), CG_LEFT_ALIGN%
        Next vti%
    Else
        'Indices de las columnas a imprimir, tamaño en caracteres para cada columna,
        For vti% = 0 To parNColumnas - 1
            VTReport.PMPutColumn vti%, Val(parColumnas(vti%)), Val(parSepColumnas(vti%)), Val(parAlineacion(vti%))
        Next vti%
    End If
    'xrs: 12-10-99 UF
    
    'Impresión del reporte
    'VTReport.PMPrintReport vbPRORPortrait
    'haq 19-7-99 se indica si la orientacion de la impresion vertical y horizontal
    VTReport.PMPrintReport (parOrientacion)
    
    'Se libera el objeto
    Set VTReport = Nothing
    
    Printer.ScaleMode = VTUnidad  'xrs: 22-10-99 II, Guardar la unidad anterior
End Sub


'FIXIT: Declare 'parGrid' and 'parColumnas' and 'parSepColumnas' and 'parCaptionSubTitulos' and 'parValuesSubTitulos' and 'parAlineacion' and 'parOrientacion' with an early-bound data type     FixIT90210ae-R1672-R1B8ZE
Public Sub PMImprimirReporte1(parGrid As Object, parNColumnas As Integer, parColumnas() As Integer, parSepColumnas() As Integer, parTitulo As Integer, parCaptionSubTitulos() As Integer, parValuesSubTitulos() As String, parAlineacion() As Integer, Optional parOrientacion As Integer = CG_PORTRAIT%)
'*************************************************************
'PROPOSITO: Realizar la impresión de reportes utilizando un
'            objeto de la clase PrinterDll.Report (printerDll.dll)
' INPUT    : parGrid              Grid que que se va a imprimir
'            parNColumnas         Número de columnas a imprimir
'            parColumnas          Contiene los índices de las columnas a imprimir
'            parSepColumnas       Contiene las separaciones entre columnas (en caracteres)
'            parTitulo            Contiene el número de recurso del título
'            parCaptionSubTitulos Contiene los números de recurso de las etiquetas de los subtítulos
'            parValuesSubTitulos  Contiene los valores que se desplegarán en los subtítulos (strings)
'            parAlineacion        Arreglo que contiene la alineación de las columnas, si su dimensión es 0 toma como default la alineación a la izq.
'            parOrientacion       Contiene la orientacion de la impresion, Vertical, Horizontal
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 22-Dic-98      X. Ramos       Emision Inicial
'*************************************************************
    
    Dim VTReport As PrinterDll.Report
    Dim vti As Integer
    Dim VTRet As Integer
    Dim VTUnidad As Integer 'xrs: 22-09-99
      
    VTUnidad = Printer.ScaleMode    'xrs: 22-09-99
    
    'Verificación de existencia de registros en el grid
    If parGrid.MaxRows = 0 Then
        VTRet% = FMMsgBox(15155, vbExclamation, 15001, "", "")
        Exit Sub
    End If
    
    'Creación del Objeto Report
    Set VTReport = New PrinterDll.Report
    
    'Printer.ScaleMode = vbCharacters    'xrs: 22-09-99
    Printer.ScaleMode = vbCentimeters    'xrs: 21-11-99
    
    'Definición de atributos del Título
    VTReport.FMSetTitleAlign CG_CENTER_ALIGN%
    VTReport.FMSetTitleFont "Courier"
    VTReport.FMSetTitleFontBold True
    VTReport.FMSetTitleCaption LoadResString(parTitulo)
    VTReport.FMSetTitleInEachPage True
    
    'Definición de Atributos para los subtítulos
    VTReport.FMSetHeaderPageNumbers True
    VTReport.FMSetHeaderAlign CG_LEFT_ALIGN%
    VTReport.FMSetHeaderFontBold False
    VTReport.FMSetHeaderInEachPage True
    VTReport.FMSetHeaderShowDate True
    
    'Definicion de Caption y Value de cada Subtítulo
    VTReport.FMSetHeaderNSubTitles UBound(parCaptionSubTitulos) + 1 'Número de Subtítulos
    For vti% = 0 To UBound(parCaptionSubTitulos)
        VTReport.FMPutHeaderSubtitle vti%, LoadResString(Val(parCaptionSubTitulos(vti%))), CStr(parValuesSubTitulos(vti%))
    Next vti%
    
    
    'DEFINICION DE DETAIL
    'Tamaño de letra del detalle del reporte
    VTReport.FMSetDetailSize (7)
    
    'Número de columnas de impresión
    VTReport.FMSetReportNColumns parNColumnas
    
    'Carga de los parámetros y valores del grid a imprimir
    VTReport.PMLoad_Parameters parGrid
        
    'xrs: 12-10-99 UI, Alineación de las columnas.
    If UBound(parAlineacion) = 0 Then
        'Indices de las columnas a imprimir, tamaño en caracteres para cada columna,
        For vti% = 0 To parNColumnas - 1
            VTReport.PMPutColumn vti%, Val(parColumnas(vti%)), Val(parSepColumnas(vti%)), CG_LEFT_ALIGN%
        Next vti%
    Else
        'Indices de las columnas a imprimir, tamaño en caracteres para cada columna,
        For vti% = 0 To parNColumnas - 1
            VTReport.PMPutColumn vti%, Val(parColumnas(vti%)), Val(parSepColumnas(vti%)), Val(parAlineacion(vti%))
        Next vti%
    End If
    'xrs: 12-10-99 UF
    
    'Impresión del reporte
    'VTReport.PMPrintReport vbPRORPortrait
    'haq 19-7-99 se indica si la orientacion de la impresion vertical y horizontal
    VTReport.PMPrintReport (parOrientacion)
    
    'Se libera el objeto
    Set VTReport = Nothing
    
    Printer.ScaleMode = VTUnidad  'xrs: 22-10-99 II, Guardar la unidad anterior
End Sub

