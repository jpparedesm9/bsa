VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FBuscarGrupo 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Búsqueda de Grupos Económicos"
   ClientHeight    =   4170
   ClientLeft      =   840
   ClientTop       =   1875
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
   Icon            =   "FBUSGRP.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4170
   ScaleWidth      =   7770
   Begin VB.TextBox txtValor 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1755
      TabIndex        =   2
      Text            =   "%"
      Top             =   885
      Width           =   5085
   End
   Begin VB.Frame fraCriterio 
      Caption         =   "Criterio de Búsqueda"
      ForeColor       =   &H000000FF&
      Height          =   855
      Left            =   30
      TabIndex        =   8
      Top             =   15
      Width           =   6810
      Begin VB.OptionButton optCriterio 
         Caption         =   "Alfabético"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   0
         Left            =   1950
         TabIndex        =   0
         Top             =   270
         Value           =   -1  'True
         Width           =   1170
      End
      Begin VB.OptionButton optCriterio 
         Caption         =   "Código"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   1
         Left            =   1965
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   510
         Width           =   1050
      End
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
      Left            =   6885
      Picture         =   "FBUSGRP.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   3405
      Width           =   875
   End
   Begin VB.CommandButton cmdEscoger 
      Caption         =   "&Escoger"
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
      Left            =   6885
      Picture         =   "FBUSGRP.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   2640
      Width           =   875
   End
   Begin VB.CommandButton cmdBuscar 
      Caption         =   "Si&gtes."
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
      Left            =   6885
      Picture         =   "FBUSGRP.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1875
      Width           =   875
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
      Left            =   6885
      Picture         =   "FBUSGRP.frx":0C08
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   1110
      Width           =   875
   End
   Begin MSGrid.Grid grdResultados 
      Height          =   2970
      Left            =   45
      TabIndex        =   7
      Top             =   1185
      Width           =   6795
      _Version        =   65536
      _ExtentX        =   11986
      _ExtentY        =   5239
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      Caption         =   "Valor de Búsqueda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   60
      TabIndex        =   9
      Top             =   900
      Width           =   1680
   End
End
Attribute VB_Name = "FBuscarGrupo"
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
' Forma: FBuscarGrupo
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
Dim VLcriterio%

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
Dim KeyAscii%
    KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
Dim VTCriterio$
Dim VTModo%
    'Determinar Criterio de Búsqueda -> parámetro @i_tipo
    If optCriterio(0).Value Then 'alfabetico
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "2"
        VTCriterio$ = "A"
    Else 'codigo
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "1"
        VTCriterio$ = "C"
    End If
    'Buscar los 20 primeros o los siguientes
    Select Case Index
    Case 0      '20 primeros
            VTModo% = False
            'Determinar Valor de búsqueda
            If InStr(1, txtValor.Text, "%") = 0 Then
                'buscar un valor específico
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "2"
            Else
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
                 PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, (txtValor.Text)
            End If
    Case 1
            VTModo% = True
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
             PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, (txtValor.Text)
            Select Case VTCriterio$
            Case "A"
                grdResultados.Row = grdResultados.Rows - 1
                grdResultados.Col = 2
                 PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, (grdResultados.Text)
            Case "C"
                grdResultados.Row = grdResultados.Rows - 1
                grdResultados.Col = 1
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4&, (grdResultados.Text)
            End Select
    End Select
    'codigo de transaccion
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "150"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qr_grupo", True, "Búsqueda de Clientes") Then
         PMMapeaGrid sqlconn&, grdResultados, VTModo%
         PMChequea sqlconn&
        If Val(grdResultados.Tag) >= VGMaximoRows% - 1 Then
            cmdBuscar(1).Enabled = True
        Else
            cmdBuscar(1).Enabled = False
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
    If grdResultados.Rows >= 2 And grdResultados.Text <> "" Then
        grdResultados.Row = VTRow%
        VTCols% = grdResultados.Cols - 1
        ReDim VGBusqueda(0 To VTCols%)
        VGBusqueda(0) = "G"
        For i% = 1 To grdResultados.Cols - 1
            grdResultados.Col = i%
            VGBusqueda(i%) = grdResultados.Text
        Next i%
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        FBuscarGrupo.Hide
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
    FBuscarGrupo.Hide
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
    VLcriterio% = 0
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
    PMLineaG grdResultados
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
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Doble-click para Escoger un Grupo Económico"
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
    Select Case Index
    Case 0
        'Código
        If Value = True Then
            If VLcriterio% <> 0 Then 'estaba seleccionado otro criterio
                VLcriterio% = 0
                txtValor.Text = "%"
                cmdBuscar(1).Enabled = False
            End If
        End If
    Case 1
        'Alfabético
        If Value = True Then
            If VLcriterio% <> 1 Then 'estaba seleccionado otro criterio
                VLcriterio% = 1
                txtValor.Text = "%"
                cmdBuscar(1).Enabled = False
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
    FPrincipal.pnlHelpLine.Caption = "Dar el valor inicial de Búsqueda"
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
    KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))

End Sub

Private Sub txtValor_LostFocus()
    txtValor.Text = Trim$(UCase$((txtValor.Text)))
End Sub



