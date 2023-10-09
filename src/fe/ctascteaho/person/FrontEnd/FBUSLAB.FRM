VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FBuscarLabor 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Búsquedas para Personalizacion de Costos de Servicios"
   ClientHeight    =   4170
   ClientLeft      =   570
   ClientTop       =   2220
   ClientWidth     =   7770
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "FBUSLAB.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4170
   ScaleWidth      =   7770
   Begin VB.OptionButton optCriterio 
      Caption         =   "Empresas en las que labora una persona determinada"
      ForeColor       =   &H00400000&
      Height          =   210
      Index           =   2
      Left            =   810
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   885
      Width           =   5000
   End
   Begin MSGrid.Grid grdResultados 
      Height          =   2565
      Left            =   15
      TabIndex        =   5
      Top             =   1560
      Width           =   6795
      _Version        =   65536
      _ExtentX        =   11986
      _ExtentY        =   4525
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.OptionButton optCriterio 
      Caption         =   "Empresas que forman parte de un grupo"
      ForeColor       =   &H00400000&
      Height          =   210
      Index           =   0
      Left            =   810
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   360
      Width           =   5000
   End
   Begin VB.OptionButton optCriterio 
      Caption         =   "Personas que trabajan en una empresa determinada"
      ForeColor       =   &H00400000&
      Height          =   210
      Index           =   1
      Left            =   810
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   630
      Width           =   5000
   End
   Begin VB.TextBox txtValor 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1275
      TabIndex        =   3
      Top             =   1245
      Width           =   1000
   End
   Begin VB.Frame fraCriterio 
      Caption         =   "Criterio de Búsqueda"
      ForeColor       =   &H000000FF&
      Height          =   1150
      Left            =   0
      TabIndex        =   9
      Top             =   75
      Width           =   6810
   End
   Begin VB.CommandButton cmdSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Left            =   6840
      Picture         =   "FBUSLAB.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   3390
      Width           =   900
   End
   Begin VB.CommandButton cmdEscoger 
      Caption         =   "&Escoger"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Left            =   6840
      Picture         =   "FBUSLAB.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   2625
      Visible         =   0   'False
      Width           =   900
   End
   Begin VB.CommandButton cmdBuscar 
      Caption         =   "Si&guiente"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   6840
      Picture         =   "FBUSLAB.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   1860
      Width           =   900
   End
   Begin VB.CommandButton cmdBuscar 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   6840
      Picture         =   "FBUSLAB.frx":0C08
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1095
      Width           =   900
   End
   Begin VB.Label lblEtiqueta 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      Caption         =   "Persona:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   240
      TabIndex        =   12
      Top             =   1305
      Width           =   765
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      Caption         =   "Empresa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   240
      TabIndex        =   13
      Top             =   1305
      Width           =   1005
   End
   Begin VB.Label lblnombre 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2310
      TabIndex        =   11
      Top             =   1245
      Width           =   4500
   End
   Begin VB.Label lblEtiqueta 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      Caption         =   "Grupo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   240
      TabIndex        =   10
      Top             =   1305
      Width           =   585
   End
End
Attribute VB_Name = "FBuscarLabor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*********************************************************
'   Archivo:        FBUSGRP.FRM
'   Producto:       Master Information Subsystem
'   Diseñado por:   Myriam Dávila
'   Fecha de Documentación: 14/Ene/94
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
' Forma: FBusLabor
' Descripción: Esta forma resuelve la búsqueda de Grupos
'              Económicos, y permite del resultado de la
'              búsqueda escoger los datos correspondientes
'              a un grupo. La forma de comunicación con la
'              rutina desde la cual fue llamada esta búsque-
'              da es a través del Arreglo de Strings
'              VGBusqueda() el cual debe ser declarado en el
'              módulo global de la aplicación en la que esta
'              forma se utiliza.
'              Si un grupo   fue escogido -> VGBusqueda(1) <> ""
'              Si no se escogió cliente -> VGBusqueda(1) = ""
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'           VGBusqueda()        arreglo global que guarda
'                               en forma temporal los campos
'                               del registro seleccionado
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
'*********************************************************

'Variables Locales
Dim VLcriterio%  'para conocer en que opción se encuentra
'! removed Dim VLNumLin As Integer


Private Sub cmdBuscar_Click(Index As Integer)
'*********************************************************
'Objetivo:  Rutina para buscar grupos económicos por código
'           o en orden alfabético. Esta rutina sirve a los
'           botones buscar y siguientes
'Input   :  Index       identifica al botón.
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
Dim VTlblsp$
Dim VTModo%
    If txtValor.Text = "" Then
        MsgBox "Debe Ingresar el Código del Cliente", 16, " Mensaje de Error"
        'txtValor.SetFocus
        Exit Sub
    End If
 
 If VLcriterio% = 0 Then
       VTlblsp$ = "busqueda de empresas de un grupo"
 End If
 If VLcriterio% = 1 Then
       VTlblsp$ = "busqueda de personas de una empresa"
 End If
 If VLcriterio% = 2 Then
       VTlblsp$ = "busqueda de empresas laboró una persona"
 End If

    'Buscar los 20 primeros
    Select Case Index
    Case 0      '20 primeros  o botón escoger
        VTModo% = False
        If VLcriterio% = 0 Then 'empresas que conforman un grupo
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1253"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "EXG"
             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4&, txtValor
        End If
        If VLcriterio% = 1 Then 'personas que trabajan en una empresa X
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1255"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "PXE"
             PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4&, txtValor
   
        End If
        If VLcriterio% = 2 Then 'empresas en las que labora una persona X
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1254"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "EXP"
             PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4&, txtValor
        End If

    Case 1     ' el botón de siguientes
        VTModo% = True
        grdResultados.Row = grdResultados.Rows - 1
        grdResultados.Col = 1
        If VLcriterio% = 0 Then 'empresas que conforman un grupo
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1253"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "EXG"
             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4&, txtValor
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4&, grdResultados.Text
        End If
        If VLcriterio% = 1 Then 'personas que trabajan en una empresa X
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1255"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "PXE"
             PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4&, txtValor
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4&, grdResultados.Text
        End If
        If VLcriterio% = 2 Then 'empresas en las que labora una persona X
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1254"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "EXP"
             PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4&, txtValor
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4&, grdResultados.Text
        End If
    End Select

     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_laboral", True, VTlblsp$) Then
         PMMapeaGrid sqlconn&, grdResultados, VTModo%
         PMChequea sqlconn&
        If Val(grdResultados.Tag) >= VGMaxRows% Then
            cmdBuscar(1).Enabled = True
            cmdEscoger.Enabled = True
        Else
            cmdBuscar(1).Enabled = False
        End If
        If grdResultados.Rows > 21 Then
            grdResultados.TopRow = grdResultados.Rows - VGMaximoRows% + 1
        End If
    End If
End Sub

Private Sub cmdBuscar_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  Index       identifica al botón.
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Select Case Index
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Buscar Grupos Económicos de acuerdo a especificaciones"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Buscar el siguiente conjunto de Grupos Económicos"
    End Select
End Sub

Private Sub cmdEscoger_Click()
'*********************************************************
'Objetivo:  Esta rutina pasa el contenido de la línea del
'           grid escogida al arreglo global VGBusqueda pa-
'           ra que, al salir de esta forma, se pueda tener
'           los datos de un cliente.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
Dim VTRow%
Dim VTCols%
Dim i%
    'Almacenar la línea escogida en el grid
    VTRow% = grdResultados.Row
    'Verificar que el grid contenga datos
    grdResultados.Col = 1
    grdResultados.Row = 1
    If grdResultados.Text <> "" Then
        grdResultados.Row = VTRow%
        VTCols% = grdResultados.Cols - 1
        ReDim VGBusqueda(0 To VTCols%)
        VGBusqueda(0) = txtValor.Text
        For i% = 1 To grdResultados.Cols - 1
            grdResultados.Col = i%
            VGBusqueda(i%) = grdResultados.Text
        Next i%
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        FBuscarLabor.Hide
    End If
End Sub

Private Sub cmdEscoger_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = "Escoger un Grupo Económico"
End Sub

Private Sub cmdSalir_Click()
'*********************************************************
'Objetivo:  Inicializa el arreglo global VGBusqueda y ocul-
'           ta la forma (no la descarga)
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    ReDim VGBusqueda(1)
    txtValor.Text = ""
    lblnombre.Caption = ""
    FBuscarLabor.Hide
End Sub

Private Sub cmdSalir_GotFocus()
    FPrincipal.pnlHelpLine.Caption = "Salir de la Forma de Búsqueda"
End Sub

Private Sub Form_Load()
'*********************************************************
'Objetivo:  Inicializa la variable local que controla los
'           criterios
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
Dim VLNunLin As Integer
    VLNunLin = 0
    lblEtiqueta(0).Visible = False
    lblEtiqueta(1).Visible = False
    lblEtiqueta(2).Visible = False
    cmdBuscar(1).Enabled = False
    cmdEscoger.Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de Mensaje y Transaccion
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""

End Sub

Private Sub grdResultados_Click()
'*********************************************************
'Objetivo:  Selecciona una línea del grid
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
End Sub

Private Sub grdResultados_DblClick()
'*********************************************************
'Objetivo:  Llama a la rutina del botón escoger
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    cmdEscoger_Click
End Sub

Private Sub grdResultados_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
End Sub

Private Sub optCriterio_Click(Index As Integer)
Dim Value As Integer
Value = optCriterio(Index).Value
optCriterio_ClickHelper Index, Value
End Sub
Private Sub optCriterio_ClickHelper(Index As Integer, Value As Integer)
'*********************************************************
'Objetivo:  Nos permite escoger un criterio de búsqueda.
'           Cuando el criterio cambia, inicializa el cam-
'           po valor a "%"
'Input   :  Index       identifica al option buttom
'                       0 Codigo | 1 Alfabético
'           Value       indica si el option buttom está
'                       activo o no.
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
 lblEtiqueta(0).Visible = False
 lblEtiqueta(1).Visible = False
 lblEtiqueta(2).Visible = False
    Select Case Index
    Case 0
        'Empresas que forman parte de un grupo
        If Value = True Then
            If VLcriterio% <> 0 Then 'estaba seleccionado otro criterio
                VLcriterio% = 0
                cmdBuscar(1).Enabled = False
                lblEtiqueta(0).Visible = True
                txtValor.Text = ""
                lblnombre.Caption = ""
                PMLimpiaGrid grdResultados
            End If
        End If
    Case 1
        'Personas que trabajan en una empresa determinada
        If Value = True Then
            If VLcriterio% <> 1 Then 'estaba seleccionado otro criterio
                VLcriterio% = 1
                cmdBuscar(1).Enabled = False
                 lblEtiqueta(1).Visible = True
                 txtValor.Text = ""
                 lblnombre.Caption = ""
                 PMLimpiaGrid grdResultados
            End If
        End If
    Case 2
        'Empresas en que labora una persona determinada
        If Value = True Then
            If VLcriterio% <> 2 Then 'estaba seleccionado otro criterio
                VLcriterio% = 2
                cmdBuscar(1).Enabled = False
                lblEtiqueta(2).Visible = True
                txtValor.Text = ""
                lblnombre.Caption = ""
                PMLimpiaGrid grdResultados
            End If
        End If
    End Select
End Sub

Private Sub optCriterio_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  Index       identifca al option buttom
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Seleccionar el Criterio de Búsqueda"
    Select Case Index
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Empresas que forman parte de un grupo"
        'Empresas que forman parte de un grupo
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Personas que trabajan en una empresa determinada"
        'Personas que trabajan en una empresa determinada
    Case 2
        FPrincipal.pnlHelpLine.Caption = "Empresas en que labora una persona determinada"
        'Empresas en que labora una persona determinada
    End Select

End Sub

Private Sub txtValor_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlTransaccionLine.Caption = ""
    If optCriterio(0).Value = True Then
        FPrincipal.pnlHelpLine.Caption = "Código del Grupo [F5] Ayuda"
    End If
    If optCriterio(1).Value = True Then
        FPrincipal.pnlHelpLine.Caption = "Código de la Empresa [F5] Ayuda"
    End If
    If optCriterio(2).Value = True Then
        FPrincipal.pnlHelpLine.Caption = "Código de la Persona [F5] Ayuda"
    End If
End Sub

Private Sub txtValor_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VLPaso%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        If optCriterio(0).Value = True Then
            FBuscarGrupo.Show 1
            If VGBusqueda(1) <> "" Then
                txtValor.Text = VGBusqueda(1)
                lblnombre.Caption = VGBusqueda(2)
           ' Else
           '     VLPaso% = False
           '     txtValor_LostFocus
            End If
            Exit Sub
        End If
        If optCriterio(1).Value = True Then
            FBuscarCliente.optCliente(0).Enabled = False
            FBuscarCliente.optCliente(1).Enabled = True
            FBuscarCliente.optCliente(1).Value = True
            FBuscarCliente.Show 1
            If VGBusqueda(1) <> "" Then
                txtValor.Text = VGBusqueda(1)
                lblnombre.Caption = VGBusqueda(2) + " " + VGBusqueda(3) + " " + VGBusqueda(4)
           ' Else
           '     VLPaso% = False
           '     txtValor_LostFocus
            End If
            Exit Sub
        End If
        If optCriterio(2).Value = True Then
            FBuscarCliente.optCliente(0).Enabled = True
            FBuscarCliente.optCliente(1).Enabled = False
            FBuscarCliente.optCliente(0).Value = True
            FBuscarCliente.Show 1
            If VGBusqueda(1) <> "" Then
                txtValor.Text = VGBusqueda(1)
                lblnombre.Caption = VGBusqueda(2)
            'Else
            '    VLPaso% = False
            '    txtValor_LostFocus
            End If
            Exit Sub
        End If
    End If
End Sub

Private Sub txtValor_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea alfanumerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'22/Ene/94  M.Davila            Emisión Inicial
'*********************************************************
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtValor_LostFocus()
Dim VTlblsp$
Dim VTsp$
Dim VTR%
    txtValor.Text = Trim$(txtValor.Text)
    If Val(txtValor.Text) > 999999 Then
        MsgBox "El valor no debe exeder de 999999", 48, "Control de Ingreso de Datos"
        txtValor.SetFocus
    End If

 If txtValor.Text = "" Then
    cmdBuscar(0).Enabled = False
 Else
    cmdBuscar(0).Enabled = True
 End If

    If VLcriterio% = 0 Then
        VTlblsp$ = "busqueda de empresas de un grupo"
    End If
    If VLcriterio% = 1 Then
        VTlblsp$ = "busqueda de personas de una empresa"
    End If
    If VLcriterio% = 2 Then
        VTlblsp$ = "busqueda de empresas laboró una persona"
    End If

    If VLcriterio% = 0 Then 'empresas que conforman un grupo
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1184"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
         PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4&, txtValor.Text
        VTsp$ = "sp_grupo"
        ReDim VGBusqueda(17)
    End If
    If VLcriterio% = 1 Or VLcriterio% = 2 Then 'personas o companias
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1190"
         PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, txtValor.Text
        VTsp$ = "sp_qrente"
        ReDim VGBusqueda(3)
    End If
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", VTsp$, True, VTlblsp$) Then
         VTR% = FMMapeaArreglo(sqlconn&, VGBusqueda())
         PMChequea sqlconn&
        If VLcriterio% = 0 Then
             txtValor.Text = VGBusqueda(1)
             lblnombre.Caption = VGBusqueda(2)
        End If
        If VLcriterio% = 1 Or VLcriterio% = 2 Then
             lblnombre.Caption = Trim$(VGBusqueda(1))
        End If
    End If

End Sub



