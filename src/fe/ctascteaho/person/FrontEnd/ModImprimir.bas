Attribute VB_Name = "ModImprimir"
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
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

    Dim VTPos As Long         'Posición donde se encuentra el token
    Dim VTchar As String      'Caracter temporal
    Dim VTIndice As String    'Valor ## del token parToken
    Dim VTcont As Long        'Contador temporal
    
    VTPos& = InStr(parCad$, parToken$)
    If VTPos& > 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VTchar$ = Mid$(parCad$, VTPos& + Len(parToken$), 1)
        VTcont& = 1
        VTIndice$ = ""
        Do While IsNumeric(VTchar$)
            VTIndice$ = VTIndice$ + VTchar$
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VTchar$ = Mid$(parCad$, VTPos& + Len(parToken$) + VTcont&, 1)
            VTcont& = VTcont& + 1
        Loop
        
        If IsNumeric(VTIndice$) Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
            parCad$ = LTrim$(Left$(parCad$, VTPos& - 1) + Mid$(parCad$, VTPos& + Len(parToken$) + VTcont& - 1))
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

    Dim VTPos As Long             'Posición donde se encuentra un token \Field
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
    
    
'! removed Dim pruebacadena As String

    
    VTNumDatos& = UBound(parDatos$, 1)
    VTDiferencia& = 0
    
    If VTNumDatos& > 0 Then
        VTPos& = InStr(parCad$, "\Field")
        Do While VTPos& > 0
            VTDiferencia& = 6
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VTchar$ = Mid$(parCad$, VTPos& + 6, 1)
            VTcont& = 1
            VTIndice$ = ""
            If IsNumeric(VTchar$) Then
                Do While VTchar$ <> " "
                    VTIndice$ = VTIndice$ + VTchar$
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                    VTchar$ = Mid$(parCad$, VTPos& + 6 + VTcont&, 1)
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
                    If (InStr(parCad$, "\MaxLong") + Len(CStr(VTMaxLong&)) + 9) = VTPos& Then
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
                               VTPos& = InStr(parCad$, "\Field")
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTPos& - 1) + VTValor$ + Mid$(parCad$, VTPos& + VTDiferencia&)
                           Else
                               'Poner espacios en blanco luego del Field reemplazado hasta completar VTMaxLong
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTPosMaxLong& - 1) + Mid$(parCad$, VTPosMaxLong& + Len("\MaxLong" + CStr(VTMaxLong&)))
                               VTValor$ = VTValor$ + Space$(VTMaxLong& - Len(VTValor$))
                               VTPos& = InStr(parCad$, "\Field")
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                               parCad$ = Left$(parCad$, VTPos& - 1) + VTValor$ + Mid$(parCad$, VTPos& + VTDiferencia&)
                           End If
                        End If
                    Else
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                        parCad$ = Left$(parCad$, VTPos& - 1) + VTValor$ + Mid$(parCad$, VTPos& + VTDiferencia&)
                    End If
                Else
                    VTMensaje$ = FMResolveResString(15128, "|1", VTIndice$)
                    VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
                    Exit Sub
                End If
            End If
            VTPos& = VTPos& + VTDiferencia&
            VTPos& = InStr(VTPos&, parCad$, "\Field")
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
    Dim VTPos As Integer         'posicion en la que se encuentra un espacio para aumentar otro espacio
    Dim VTi As Integer           'sitio desde el cual se busca un nuevo espacio
    Dim VTpasada As Integer      'Número de veces que ha pasado la cadena aux para ser completada con espacios
    Dim VTAncho As Single        'Ancho de la hoja
    Dim VTAlto As Single         'Alto de la Hoja
'! removed Dim VTNLine As Long
'Sitio donde hay una nueva linea
    Dim VTLon_Aux As Integer     'Longitud auxiliar del ancho de una linea
    Dim VTPIntermedio As Integer 'Indica si se debe imprimir desde un sitio que no sea el borde horizontal.
    Dim VTNLineas As Integer     'No. de líneas impresas
    Dim VTLon As Integer         'Longitud del ancho de la página
    
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.CurrentY = parY!
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.FontBold = parFBold%
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.FontUnderline = parFUnderline%
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.FontSize = parFSize&
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.DrawWidth = 10
    
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    VTAncho! = Printer.ScaleWidth - 1 - 2 * parHBorder!
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    VTAlto! = Printer.ScaleHeight - 1 - 2 * parVBorder!
    
    VTLon_Aux% = 0
    VTPIntermedio% = 0
    VTNLineas% = 0
    
    'Si la cadena se debe empezar a escribir desde una posición diferente del borde Horizontal
    If parX! > parHBorder Then
        VTi% = 1
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
        Do While Printer.TextWidth(String$(VTi%, 32)) <= (parHBorder! + VTAncho! - parX!)
            VTi% = VTi% + 1
        Loop
        VTPIntermedio% = 1
        VTLon_Aux% = VTi% - 1
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = parX!
    Else
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = parHBorder!
    End If
    
    'Determinar el número de caracteres que se requieren para completar el ancho de la hoja
    VTi% = 1
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
    Do While Printer.TextWidth(String$(VTi%, 32)) <= VTAncho!
        VTi% = VTi% + 1
    Loop
    
    'Si se tiene que empezar a escribir desde el borde
    If VTPIntermedio% = 0 Then
        VTLon% = VTi% - 1
    Else
        VTLon% = VTLon_Aux%
        VTLon_Aux% = VTi% - 1
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
            
            VTi% = 1
            VTpasada% = 1
            Do While VTVeces% > 0
                VTPos% = InStr(VTi%, VTAux$, " ")
                If VTPos% > 0 Then
                   VTAux$ = Left$(VTAux$, VTPos% - 1) + Space$(VTpasada% + 1) + Mid$(VTAux$, VTPos% + VTpasada%)
                   VTi% = VTPos% + VTpasada% + 1
                   VTVeces% = VTVeces% - 1
                Else
                    If VTpasada% = 1 And VTVeces% = (VTLon% - (VTSitio% - 1)) Then     'Si no hay ningun espacio se trunca LA CADENA
                        VTSitio% = VTLon%
                        VTAux$ = Left$(parCad$, VTSitio%)
                        VTVeces% = 0
                    Else
                        VTi% = 1
                        VTpasada% = VTpasada% + 1
                    End If
                End If
            Loop
            
            parCad$ = Mid$(parCad$, VTSitio% + 1)
            
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            If (Printer.CurrentY + Printer.TextHeight(" ")) > (parVBorder! + VTAlto!) Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                Printer.NewPage
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                Printer.CurrentX = parHBorder!
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                Printer.CurrentY = parVBorder!
            End If
            
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            Printer.Print VTAux$
            
            VTNLineas% = VTNLineas% + 1
            
            If VTPIntermedio% <> 0 Then VTLon% = VTLon_Aux%
            
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            Printer.CurrentX = parHBorder!
        Loop
    End If
    
    If VTNLineas% > 0 Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = parHBorder!
    Else
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = parX!
    End If
    
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
     If (Printer.CurrentY + Printer.TextHeight(" ")) > (parVBorder! + VTAlto!) Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.NewPage
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = parHBorder!
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentY = parVBorder!
     End If
    
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.Print parCad$;
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    parY! = Printer.CurrentY
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
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
'! removed Dim VTPosTitl As Long
'Posicion donde se encuentra token de Titulo
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


'! 'Public Sub PMRead_Carga(parArch As String, parGrid As Control, parOpcional As Integer)
'! ''*************************************************************
'! ''PROPOSITO: Leer un archivo .txt para separar filas y grabar
'! ''            datos de impresión en lotes
'! '' INPUT    : parArchivo: Nombre del archivo .txt
'! ''            pargrid   : Grid donde se colocaran los datos
'! ''            parOpcional: a partir de que parametro se envia si existe  el dato
'! '' OUTPUT   : Ninguno
'! ''*************************************************************
'! ''                       MODIFICACIONES
'! '' FECHA          AUTOR           RAZON
'! '' 29-May-2002    D.Villagómez    Emisión Inicial
'! '' 17-Jun-2003    V. Morejon      Trim del arreglo que lee los
'! ''                                parametros variables del archivo
'! ''                                de texto para que cuando sea
'! ''                                " " se compare con "" y se envie null
'! ''*************************************************************
'! '
'! '    Const CL_CHECKED% = 1                'Estado checked de un CheckBox
'! '    Const CL_UNCHECKED% = 0              'Estado unchecked de un CheckBox de dos estados
'! '    Const CL_CHKBOX_DOS% = 0             'Para crear checkbox con 2 estados
'! '    Const CL_CELLTYPE% = 10              'Tipo checkbox para una celda de un fpSpread
'! '
'! '
'! '    Const CL_CHECKED_TEXT$ = "OK"        'Texto para el estado checked de un CheckBox : Entregado OK
'! '    Const CL_UNCHECKED_TEXT$ = "ERROR"   'Texto para el estado unchecked de un CheckBox : Por verificar
'! '
'! '
'! '    Dim VTchar As String            'Caracter temporal
'! '    Dim VTCadena_Archivo As String  'Contenido del archivo
'! '    Dim VTCad As String             'Almacena los párrafos (de uno en uno) del archivo
'! '    Dim VTFNum As Long              'Número de apertura del archivo
'! '    Dim VTcont As Long              'Contador Temporal
'! '    Dim VTPos As Integer            'Posición donde se encuentra un caracter buscado.
'! '    Dim VTPos2 As Integer           'Posición donde se encuentra un caracter buscado.
'! '    Dim VTRet As Integer            'Retorno del mensaje de error
'! '    Dim VTMensaje As String         'Mensaje de error
'! '    Dim VTArrayCampos() As String   'Arreglo donde se grabaran los campos de cada fila
'! '    Dim VTcontador As Integer       ' contador de campos
'! '    Dim VTCampo As String           ' cadena que guarda un campo
'! '    Dim VTi As Integer              ' acumulador
'! '    Dim VTLineas As Long             ' Número de registros leidos
'! '    Dim VTEstado As Boolean         ' indica si la línea se leyó correctamente
'! '    Dim VLCodOpe As String
'! '    Dim VLblanco As Boolean         ' valida si existe una linea en blanco
'! '    VLCodOpe$ = "0"
'! '    VTLineas = 0
'! '
'! '    VTFNum& = FreeFile
'! '    On Error GoTo mensaje
'! '    ReDim VTArrayCampos(VGPArch%)
'! '    Open parArch$ For Input As #VTFNum&
'! '
'! '    'Recuperación de datos del archivo
'! '    VTCadena_Archivo$ = Input(LOF(VTFNum&), VTFNum&)
'! '    parGrid.MaxRows = 0
'! '
'! '
'! '    'Archivo vacio
'! '    If Len(VTCadena_Archivo$) <= 0 Then
'! '        VTMensaje$ = FMResolveResString(15301, "|1", parArch$)
'! '        VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
'! '        Close VTFNum&
'! '        Exit Sub
'! '    End If
'! '
'! '    Do While Len(VTCadena_Archivo$) > 0
'! '        VLblanco = False
'! '        VTPos% = InStr(VTCadena_Archivo$, Chr$(13) + Chr$(10))
'! '        If VTPos% > 0 Then
'! '            If VTPos% < 1 Then
'! '                ' Linea en blanco
'! '                VLblanco = True
'! '                VTCad$ = ""
'! '                VTCadena_Archivo$ = Mid(VTCadena_Archivo$, VTPos% + 2)
'! '            Else
'! '                VTCad$ = Left(VTCadena_Archivo$, VTPos% - 1)
'! '                VTCadena_Archivo$ = Mid(VTCadena_Archivo$, VTPos% + 2)
'! '            End If
'! '        Else
'! '        ' se trata de la ultima linea
'! '            VTCad$ = VTCadena_Archivo$
'! '            VTCadena_Archivo$ = ""
'! '        End If
'! '
'! '        If Not VLblanco Then
'! '
'! '
'! '            ' en VTCad tengo una línea de regsitro
'! '            VTcontador% = 1
'! '            Do While Len(VTCad$) > 0
'! '                VTPos2% = InStr(VTCad$, "@")
'! '                If VTPos2% > 1 Then
'! '                    VTCampo$ = Left(VTCad$, VTPos2% - 1)
'! '                    VTCad$ = Mid(VTCad$, VTPos2% + 1)
'! '                Else
'! '                    VTCampo$ = Mid(VTCad$, 1, Len(VTCad$))
'! '                    VTCad$ = ""
'! '                End If
'! '                VTArrayCampos(VTcontador%) = VTCampo$
'! '                VTcontador% = VTcontador% + 1
'! '            Loop
'! '
'! '            For VTi% = 1 To VGPFijo%
'! '                PMPasoValores sqlconn&, AGCargaFijo(VTi%).nombre, 0, AGCargaFijo(VTi%).Tipo, AGCargaFijo(VTi%).valor
'! '            Next VTi%
'! '
'! '            For VTi% = 1 To VGPArch%
'! '                If ((VTi% < parOpcional) Or (VTi% >= parOpcional And Trim(VTArrayCampos(VTi%)) <> "")) Then
'! '                    PMPasoValores sqlconn&, AGCargaArch(VTi%).nombre, 0, AGCargaArch(VTi%).Tipo, VTArrayCampos(VTi%)
'! '                End If
'! '            Next VTi%
'! '            VTLineas = VTLineas + 1
'! '            If VLCodOpe$ = "0" Then
'! '                PMPasoValores sqlconn&, "@o_idlote", 1, SQLINT4&, "0"
'! '            Else
'! '                PMPasoValores sqlconn&, "@i_idlote", 0, SQLINT4&, VLCodOpe$
'! '
'! '            End If
'! '            If FMTransmitirRPC(sqlconn&, "", VGBaseDatosHlp$, VGSP, True, "Help") Then
'! '                PMChequea sqlconn&
'! '                If VLCodOpe$ = "0" Then
'! '                    VLCodOpe$ = FMRetParam(sqlconn&, 1)
'! '                End If
'! '
'! '                VTEstado = True
'! '            Else
'! '                PMChequea sqlconn&
'! '                VTEstado = False
'! '                PMWrite_File Left(parArch, (InStr(parArch, ".") - 1)) + ".log", CStr(VTLineas), False
'! '                VTMensaje$ = FMResolveResString(15302)
'! '                VTRet% = FMMsgBox(0, vbQuestion + vbYesNo, 15000, VTMensaje$, "")
'! '                If VTRet% = vbNo Then
'! '                    Exit Sub
'! '                End If
'! '
'! '            End If
'! '
'! '            'Tomar número de transacción asignado por el monitor transaccional
'! '            ' Carga los datos del grid
'! '            parGrid.MaxRows = parGrid.MaxRows + 1
'! '            parGrid.Row = parGrid.MaxRows
'! '            parGrid.Col = 1 ' Estado
'! '            parGrid.Row = parGrid.MaxRows
'! '            'pargrid.Text = VTEstado
'! '            parGrid.CellType = CL_CELLTYPE%
'! '            parGrid.TypeCheckType = CL_CHKBOX_DOS%
'! '            If VTEstado Then
'! '                parGrid.Value = CL_CHECKED%
'! '                parGrid.TypeCheckText = CL_CHECKED_TEXT$
'! '            Else
'! '                parGrid.Value = CL_UNCHECKED%
'! '                parGrid.TypeCheckText = CL_UNCHECKED_TEXT$
'! '            End If
'! '            parGrid.TypeCheckCenter = False
'! '            parGrid.TypeCheckTextAlign = 2
'! '
'! '            parGrid.Col = 2 ' nro de línea
'! '            parGrid.Text = VTLineas
'! '            For VTi% = 1 To VGPArch%
'! '                parGrid.Col = 2 + VTi%
'! '                parGrid.Text = VTArrayCampos(VTi%)
'! '            Next VTi%
'! '            parGrid.Col = 2
'! '            parGrid.TopRow = parGrid.Row
'! '            parGrid.Action = 0
'! '        End If
'! '    Loop
'! '
'! '    Close VTFNum&
'! '    VGIdCarga = CLng(VLCodOpe$)
'! 'fin_readfile:
'! ' Exit Sub
'! '
'! 'mensaje:
'! '    Screen.MousePointer = 0
'! '    VTMensaje$ = FMResolveResString(15299, "|1", parArch$)
'! '    VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
'! '    Resume fin_readfile
'! 'End Sub
'! Public Sub PMRead_File(parDatos() As String, parArch As String)
'! '*************************************************************
'! 'PROPOSITO: Leer un archivo .txt con el  formato establecido.
'! '            Este archivo es la plantilla que deberá imprimirse
'! ' INPUT    : parDatos : Arreglo tipo string donde se recibirán
'! '            los datos a ser impresos
'! '            parArchivo: Nombre del archivo .txt
'! ' OUTPUT   : Ninguno
'! '*************************************************************
'! '                       MODIFICACIONES
'! ' FECHA          AUTOR           RAZON
'! ' 31-Oct-1997    M.del Pozo    Emisión Inicial
'! '*************************************************************
'!
'!     Dim VTFSize As Long             'Tamaño de la letra normal
'!     Dim VTTSize As Long             'Tamaño de la letra de títulos
'!     Dim VTHBorder As Single         'Borde Horizontal
'!     Dim VTVBorder As Single         'Borde Vertical
'!     Dim VTchar As String            'Caracter temporal
'!     Dim VTCadena_Archivo As String  'Contenido del archivo
'!     Dim VTCad As String             'Almacena los párrafos (de uno en uno) del archivo
'!     Dim VTFNum As Long              'Número de apertura del archivo
'!     Dim VTcont As Long              'Contador Temporal
'!     Dim VTPos As Integer            'Posición donde se encuentra un caracter buscado.
'!     Dim VTX As Single               'Posicion en x (horizontal) desde donde se inicia la impresion
'!     Dim VTY As Single               'Posición en y (Vertical) desde donde se inicia la impresión
'!     Dim VTRet As Integer            'Retorno del mensaje de error
'!     Dim VTMensaje As String         'Mensaje de error
'!
'!     Printer.ScaleMode = 6
'!     Printer.FontName = "Courier New"
'!
'!     VTFNum& = FreeFile
'!     On Error GoTo mensaje
'!     Open parArch$ For Input As #VTFNum&
'!
'!     'Recuperación de datos del archivo
'!     VTCadena_Archivo$ = Input(LOF(VTFNum&), VTFNum&)
'!     VTFSize& = FLToken_Parameter(VTCadena_Archivo$, "\FontSize")
'!     VTTSize& = FLToken_Parameter(VTCadena_Archivo$, "\TitleSize")
'!     VTVBorder! = FLToken_Parameter(VTCadena_Archivo$, "\VBorder")
'!     VTHBorder! = FLToken_Parameter(VTCadena_Archivo$, "\HBorder")
'!
'!     VTX! = VTHBorder!
'!     VTY! = VTVBorder!
'!
'!     VTPos% = InStr(VTCadena_Archivo$, "{\Begin\}")
'!
'!     If VTPos% = 0 Then
'!        VTRet% = FMMsgBox(15127, vbCritical, 15000, "", "")
'!        Exit Sub
'!     End If
'!
'!     VTchar$ = Mid$(VTCadena_Archivo$, VTPos% + Len("{\Begin\}"), 1)
'!     VTcont& = 1
'!     Do Until VTchar$ <> Chr$(13) And VTchar$ <> Chr$(10)
'!         VTchar$ = Mid$(VTCadena_Archivo$, VTPos% + Len("{\Begin\}") + VTcont&, 1)
'!         VTcont& = VTcont& + 1
'!     Loop
'!
'!     VTCadena_Archivo$ = Mid$(VTCadena_Archivo$, VTPos% + Len("{\Begin\}") + VTcont& - 1)
'!
'!     PLReplace_Fields VTCadena_Archivo$, parDatos()
'!
'!     VTPos% = InStr(VTCadena_Archivo$, Chr$(13) + Chr$(10))
'!     Do While VTPos% > 0
'!         VTCad$ = Left(VTCadena_Archivo$, VTPos% + 1)
'!         VTX! = VTHBorder!
'!         PLApply_Tokens VTCad$, VTX!, VTY!, VTHBorder!, VTVBorder!, VTFSize&, VTTSize&
'!         VTCadena_Archivo$ = Mid(VTCadena_Archivo$, VTPos% + 2)
'!         VTPos% = InStr(VTCadena_Archivo$, Chr$(13) + Chr$(10))
'!     Loop
'!
'!     VTX! = VTHBorder!
'!     PLApply_Tokens VTCadena_Archivo$, VTX!, VTY!, VTHBorder!, VTVBorder!, VTFSize&, VTTSize&
'!     Printer.EndDoc
'!
'!     Close VTFNum&
'!
'! fin_readfile:
'!  Exit Sub
'!
'! mensaje:
'!     Screen.MousePointer = 0
'!     VTMensaje$ = FMResolveResString(15126, "|1", parArch$)
'!     VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
'!     Resume fin_readfile
'! End Sub
'!
'FIXIT: Declare 'parGrid' and 'parColumnas' and 'parSepColumnas' and 'parCaptionSubTitulos' and 'parValuesSubTitulos' and 'parAlineacion' and 'parOrientacion' with an early-bound data type     FixIT90210ae-R1672-R1B8ZE
Public Sub PMImprimirReporte(parGrid As Object, parNColumnas As Integer, parColumnas As Variant, parSepColumnas As Variant, parTitulo As Integer, parCaptionSubTitulos As Variant, parValuesSubTitulos As Variant, parAlineacion As Variant, Optional parOrientacion As Integer = CG_PORTRAIT%)
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
    Dim VTi As Integer
    Dim VTRet As Integer
    Dim VTUnidad As Integer 'xrs: 22-09-99
      
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    VTUnidad = Printer.ScaleMode    'xrs: 22-09-99
    
    'Verificación de existencia de registros en el grid
    If parGrid.MaxRows = 0 Then
        VTRet% = FMMsgBox(15155, vbExclamation, 15001, "", "")
        Exit Sub
    End If
    
    'Creación del Objeto Report
    Set VTReport = New PrinterDll.Report
    
    'Printer.ScaleMode = vbCharacters    'xrs: 22-09-99
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
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
    For VTi% = 0 To UBound(parCaptionSubTitulos)
        VTReport.FMPutHeaderSubtitle VTi%, LoadResString(Val(parCaptionSubTitulos(VTi%))), CStr(parValuesSubTitulos(VTi%))
    Next VTi%
    
    
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
        For VTi% = 0 To parNColumnas - 1
            VTReport.PMPutColumn VTi%, Val(parColumnas(VTi%)), Val(parSepColumnas(VTi%)), CG_LEFT_ALIGN%
        Next VTi%
    Else
        'Indices de las columnas a imprimir, tamaño en caracteres para cada columna,
        For VTi% = 0 To parNColumnas - 1
            VTReport.PMPutColumn VTi%, Val(parColumnas(VTi%)), Val(parSepColumnas(VTi%)), Val(parAlineacion(VTi%))
        Next VTi%
    End If
    'xrs: 12-10-99 UF
    
    'Impresión del reporte
    'VTReport.PMPrintReport vbPRORPortrait
    'haq 19-7-99 se indica si la orientacion de la impresion vertical y horizontal
    VTReport.PMPrintReport (parOrientacion)
    
    'Se libera el objeto
    Set VTReport = Nothing
    
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
    Printer.ScaleMode = VTUnidad  'xrs: 22-10-99 II, Guardar la unidad anterior
End Sub


'! Public Sub PMWrite_File(parArch As String, parLinea As String, parEstado As Boolean)
'! '*************************************************************
'! 'PROPOSITO: guardar una cadena en un archivo como log de un
'! '            proceso
'! ' INPUT    : parLinea : Linea a guardar en el archivo
'! '            los datos a ser impresos
'! '            parArch: Nombre del archivo .log
'! ' OUTPUT   : Ninguno
'! '*************************************************************
'! '                       MODIFICACIONES
'! ' FECHA          AUTOR           RAZON
'! ' 31-Oct-1997    M.del Pozo    Emisión Inicial
'! '*************************************************************
'!
'!
'!     Dim VTFNum As Long              'Número de apertura del archivo
'!     Dim VTRet As Integer
'!     Dim VTCadena As String
'!     Dim VTMensaje As String
'!     On Error GoTo mensaje
'!
'!     VTCadena$ = parLinea
'!     VTFNum& = FreeFile
'!
'!     If parEstado Then
'!         Open parArch$ For Output As #VTFNum&
'!     Else
'!         Open parArch$ For Append As #VTFNum&
'!     End If
'!
'!     Print #VTFNum, VTCadena$
'!     Close (VTFNum&)
'!
'!
'! fin_readfile:
'!  Exit Sub
'!
'! mensaje:
'!     Screen.MousePointer = 0
'!     VTMensaje$ = FMResolveResString(15303)
'!     VTRet% = FMMsgBox(0, vbCritical, 15000, VTMensaje$, "")
'!     Resume fin_readfile
'!
'! End Sub
'!

