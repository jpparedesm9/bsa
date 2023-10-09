Attribute VB_Name = "ModRes"
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          ModRes.bas
' NOMBRE LOGICO:    ModRes
' PRODUCTO:         GENERAL
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
' En este módulo suministra funciones útiles para la
' manipulacion del archivo de recursos ".RES" del módulo
' específico
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 23/Dic/97      S.Garcés        Emision Inicial
'*************************************************************

Option Explicit

Public Sub FMMsgTransaccion(parCodMsg As Integer, parTexto As String)
'*************************************************************
' PROPOSITO: Despliega mensajes de ayuda en el panel de ayuda
'            (pnlHelpLine) según el archivo de recursos
' INPUT    : parMsg     'Mensaje a desplegarse, según recursos
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 23/Dic/97      S.Garcés        Emision Inicial
' 18/Feb/99      X.Ramos         Fijar el color del texto
'*************************************************************

    Dim VTMsg As String
    
    'leer mensaje del archivo de recursos
    If parCodMsg% = 0 Then
        VTMsg$ = parTexto$
    Else
        VTMsg$ = LoadResString(parCodMsg%)
    End If
    
    'Desplegar mensaje
    FMain.pnlTransaccionLine.Caption = VTMsg$
    FMain.pnlTransaccionLine.BackColor = &H8000000F
    'xrs: 18/02/1999
    FMain.pnlTransaccionLine.ForeColor = &H80000012 'Negro
End Sub

Public Sub FMMsgAyuda(parCodMsg As Integer, parTexto As String)
'*************************************************************
' PROPOSITO: Despliega mensajes de ayuda en el panel de ayuda
'            (pnlHelpLine) según el archivo de recursos
' INPUT    : parMsg     'Mensaje a desplegarse, según recursos
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 23/Dic/97      S.Garcés        Emision Inicial
'*************************************************************

    Dim VTMsg As String
    
    'leer mensaje del archivo de recursos
    If parCodMsg% = 0 Then
        VTMsg$ = parTexto$
    Else
        VTMsg$ = LoadResString(parCodMsg%)
    End If
    
    'Desplegar mensaje
    FMain.pnlHelpLine.Caption = VTMsg$
    FMain.pnlTransaccionLine.BackColor = &H8000000F
    FMain.pnlTransaccionLine.BackColor = &H8000000F
End Sub

Public Sub PMLoadResIcons(parFrm As Form)
'*************************************************************
' PROPOSITO: Carga los íconos de una forma del archivo
'            de recursos
' INPUT    : parFrm     'Nombre de la forma
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 19/Dic/97      S.Garcés        Emision Inicial
'*************************************************************
    
    On Error Resume Next

    Dim VTCtl As Control
    Dim VTsCtlType As String
    
    'configurar el ícono de la forma
    parFrm.Icon = LoadResPicture(31000, 1)
    
    'Configurar los iconos de los botones
    'según el archivo de recursos
    For Each VTCtl In parFrm.Controls
        VTsCtlType = TypeName(VTCtl)
        If VTsCtlType = "CommandButton" Or VTsCtlType = "SSCommand" Then
'FIXIT: 'Style' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Style' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            If VTCtl.Style = 1 Then
'FIXIT: 'WhatsThisHelpID' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'WhatsThisHelpID' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'Picture' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Picture' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
                VTCtl.Picture = LoadResPicture(CInt(VTCtl.WhatsThisHelpID) + 28000, 1)
            End If
        End If
    Next
End Sub

Public Sub PMLoadResStrings(parFrm As Form)
'*************************************************************
' PROPOSITO: Carga los strings de una forma del archivo
'            de recursos
' INPUT    : parFrm     'Nombre de la forma
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 19/Dic/97      S.Garcés        Emision Inicial
'*************************************************************
    
    On Error Resume Next

    Dim VTCtl As Object 'Control
'FIXIT: Declare JTA 'VTObj' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
    Dim VTObj As Object
'FIXIT: Declare JTA 'VTFnt' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
    Dim VTFnt As Font ' Object
    Dim VTsCtlType As String
    Dim VTnVal As Integer
    
    Dim vti As Integer

    'configurar etiquetas de una forma
    parFrm.Caption = LoadResString(CInt(parFrm.Tag))
    
    'Configurar el tipo de fuente
    Set VTFnt = parFrm.Font
    VTFnt.Name = LoadResString(20)
    VTFnt.Size = CInt(LoadResString(21))
    
    'Configurar las etiquetas de los controles
    'según las propiedades establecidas para el efecto
    For Each VTCtl In parFrm.Controls
        'Set VTCtl.Font = VTFnt
        VTsCtlType = TypeName(VTCtl)
        
        If VTsCtlType = "Menu" Then
'FIXIT: 'Caption' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Caption' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'HelpContextID' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'HelpContextID' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTCtl.Caption = LoadResString(CInt(VTCtl.HelpContextID))
        ElseIf VTsCtlType = "TabStrip" Then
'FIXIT: 'Tabs' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Tabs' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            For Each VTObj In VTCtl.Tabs
                VTObj.Caption = LoadResString(CInt(VTObj.Tag))
                VTObj.ToolTipText = LoadResString(CInt(VTObj.ToolTipTextID))
            Next
        ElseIf VTsCtlType = "Toolbar" Then
'FIXIT: 'Buttons' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Buttons' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            For Each VTObj In VTCtl.Buttons
                VTObj.ToolTipText = LoadResString(CInt(VTObj.ToolTipText))
            Next
        ElseIf VTsCtlType = "ListView" Then
'FIXIT: 'ColumnHeaders' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ColumnHeaders' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            For Each VTObj In VTCtl.ColumnHeaders
                VTObj.Text = LoadResString(CInt(VTObj.Tag))
            Next
        ElseIf VTsCtlType = "TextValid" Then
'FIXIT: 'HelpLine' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'HelpLine' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'WhatsThisHelpID' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'WhatsThisHelpID' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTCtl.HelpLine = LoadResString(CInt(VTCtl.WhatsThisHelpID))
        ElseIf VTsCtlType = "MaskInBox" Then
'FIXIT: 'HelpLine' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'HelpLine' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'WhatsThisHelpID' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'WhatsThisHelpID' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTCtl.HelpLine = LoadResString(CInt(VTCtl.WhatsThisHelpID))
        ElseIf VTsCtlType = "vaSpread" Or VTsCtlType = "fpSpread" Then
'FIXIT: 'Row' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTCtl.Row = 0
'FIXIT: 'MaxCols' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'MaxCols' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            For vti% = 1 To VTCtl.MaxCols
'FIXIT: 'Col' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
                VTCtl.Col = vti%
                VTCtl.Text = LoadResString(CInt(VTCtl.Text))
            Next
        Else
            VTnVal = 0
'FIXIT: 'WhatsThisHelpID' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'WhatsThisHelpID' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTnVal = Val(VTCtl.WhatsThisHelpID)
'FIXIT: 'Caption' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Caption' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            If VTnVal > 0 Then VTCtl.Caption = LoadResString(VTnVal)
            VTnVal = 0
'FIXIT: 'ToolTipText' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ToolTipText' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            VTnVal = Val(VTCtl.ToolTipText)
'FIXIT: 'ToolTipText' JTA is not a property of the generic 'Control' object in Visual Basic .NET. To access 'ToolTipText' declare 'VTCtl' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            If VTnVal > 0 Then VTCtl.ToolTipText = LoadResString(VTnVal)
        End If
    Next
    
    ''JHI. Modificacion para validar el nombre de la forma
    parFrm.Caption = LoadResString(parFrm.Tag)
    
End Sub

Public Function FMMsgBox(parCodMsg As Integer, parButtons As Integer, parCodTitulo As Integer, parMsg As String, parTitulo As String) As Integer
'*************************************************************
' PROPOSITO: Despliega mensajes mediante un MsgBox
' INPUT    : parMsg     'Mensaje a desplegarse, según recursos
'            parButtons 'Indica tipo de botones a desplegar
'            parTitulo  'Título de la ventana, según recursos
' OUTPUT   : FMMsgBox   'Retorna botón pulsado por el usuario
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 22/Dic/97      S.Garcés        Emision Inicial
'*************************************************************

    Dim VTTitulo As String
    Dim VTMsg As String
    Dim VTRetorno As Integer
    
    'leer mensaje del archivo de recursos
    If parCodMsg% = 0 Then
        VTMsg$ = parMsg$
    Else
        VTMsg$ = LoadResString(parCodMsg%)
    End If
    
    'leer título de la ventana del archivo de recursos
    If parCodTitulo% = 0 Then
        VTTitulo$ = parTitulo$
    Else
        VTTitulo$ = LoadResString(parCodTitulo%)
    End If
    
    'Desplegar mensaje
    VTRetorno% = MsgBox(VTMsg, parButtons%, VTTitulo$)
    FMMsgBox = VTRetorno%
End Function

Public Function FMResolveResString(ByVal parResID As Integer, ParamArray parReemplazos() As Variant) As String
'*************************************************************
' PROPOSITO: Lee el recurso señalado y reemplaza las macros
'            incluidas con los valores indicados.
'
'            Ejemplo:
'               en la lectura del recurso 3105:
'                "No se puede leer '|1' en el drive |2"
'               la llamada será:
'                FMResolveResString(3105, "|1", "MAP.INI", "|2", "C:")
'               y se obtendrá el siguiente string:
'                "No se puede leer 'MAP.INI' en el drive C:"
'
' INPUT    : parResID           'Código del recurso
'            parReemplazos      'pares de valores de macro
'                                y reemplazo
' OUTPUT   : FMResolveResString 'String deseado
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 02/Sep/98      S.Garcés        Emision Inicial
'*************************************************************

    Dim VTNumMacros As Integer
    Dim VTResString As String
    Dim VTMacro As String
    Dim VTValor As String
    Dim VTpos As Integer

    FMResolveResString = ""
    VTResString$ = LoadResString(parResID%)
    
    'Por cada par de macros/valores pasados como parámetros...
    For VTNumMacros% = LBound(parReemplazos) To UBound(parReemplazos) Step 2
        VTMacro$ = parReemplazos(VTNumMacros%)
        On Error GoTo ErrParesErrados
        VTValor$ = parReemplazos(VTNumMacros% + 1)
        On Error GoTo 0
        
        ' Reemplazar cada ocurrencia de VTMacro$ con VTValor$
        Do
            VTpos% = InStr(VTResString$, VTMacro$)
            If VTpos% > 0 Then
                VTResString$ = Left$(VTResString$, VTpos% - 1) & VTValor$ & Right$(VTResString$, Len(VTResString$) - Len(VTMacro$) - VTpos% + 1)
            End If
        Loop Until VTpos% = 0
    Next VTNumMacros%
    
    FMResolveResString = VTResString$
    
    Exit Function
    
ErrParesErrados:
    Resume Next
End Function

