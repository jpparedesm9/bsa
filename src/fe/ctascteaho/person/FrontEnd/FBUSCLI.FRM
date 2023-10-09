VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FBuscarCliente 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Búsqueda de Clientes y Prospectos"
   ClientHeight    =   4710
   ClientLeft      =   570
   ClientTop       =   1365
   ClientWidth     =   8745
   ControlBox      =   0   'False
   DrawStyle       =   6  'Inside Solid
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   LinkMode        =   1  'Source
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4710
   ScaleWidth      =   8745
   Begin VB.Frame Frame3D1 
      Caption         =   "Buscar"
      ForeColor       =   &H000000FF&
      Height          =   520
      Left            =   3480
      TabIndex        =   22
      Top             =   0
      Width           =   5220
      Begin VB.OptionButton OptionAmbos 
         Caption         =   "Todos"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   2880
         TabIndex        =   4
         Top             =   225
         Value           =   -1  'True
         Width           =   900
      End
      Begin VB.OptionButton OptionProspecto 
         Caption         =   "Prospectos"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   1447
         TabIndex        =   3
         Top             =   225
         Width           =   1200
      End
      Begin VB.OptionButton OptionCliente 
         Caption         =   "Clientes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   29.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   2
         Top             =   225
         Width           =   975
      End
      Begin VB.CheckBox chkClientes 
         Caption         =   "Clientes"
         ForeColor       =   &H00800000&
         Height          =   210
         Left            =   1740
         TabIndex        =   24
         Top             =   520
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   1005
      End
      Begin VB.CheckBox chkProspecto 
         Caption         =   "Prospectos"
         ForeColor       =   &H00800000&
         Height          =   210
         Left            =   345
         TabIndex        =   23
         Top             =   520
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   1215
      End
   End
   Begin MSGrid.Grid grdResultados 
      Height          =   3030
      Left            =   0
      TabIndex        =   13
      Top             =   1680
      Width           =   7785
      _Version        =   65536
      _ExtentX        =   13733
      _ExtentY        =   5345
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
   Begin VB.TextBox txtValor 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1875
      TabIndex        =   8
      Text            =   "%"
      Top             =   1330
      Width           =   5910
   End
   Begin Threed.SSPanel lblEtiqueta 
      Height          =   255
      Index           =   0
      Left            =   150
      TabIndex        =   18
      Top             =   1330
      Width           =   1770
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   15
      Caption         =   "Valor de Búsqueda:"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   0
      BorderWidth     =   0
      BevelOuter      =   0
      RoundedCorners  =   0   'False
      FloodColor      =   8388608
      ShadowColor     =   1
      Alignment       =   1
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
      Height          =   795
      Left            =   7815
      Picture         =   "FBUSCLI.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   3885
      Width           =   900
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
      Height          =   795
      Left            =   7815
      Picture         =   "FBUSCLI.frx":0366
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   3030
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
      Height          =   795
      Index           =   1
      Left            =   7815
      Picture         =   "FBUSCLI.frx":06CC
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   2175
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
      Height          =   795
      Index           =   0
      Left            =   7815
      Picture         =   "FBUSCLI.frx":08FE
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "1182;1241;1318"
      Top             =   1320
      Width           =   900
   End
   Begin VB.Frame fraCliente 
      Caption         =   "Tipo de Cliente"
      ForeColor       =   &H000000FF&
      Height          =   520
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   3315
      Begin VB.OptionButton optCliente 
         Caption         =   "P. &Natural"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   1920
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   240
         Width           =   1185
      End
      Begin VB.OptionButton optCliente 
         Caption         =   "P.  Jurídica"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   27
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   1
         Left            =   360
         TabIndex        =   0
         Top             =   240
         Value           =   -1  'True
         Width           =   1320
      End
   End
   Begin VB.Frame fraCriterio 
      Caption         =   "Criterios de Búsqueda"
      ForeColor       =   &H000000FF&
      Height          =   675
      Left            =   0
      TabIndex        =   15
      Top             =   615
      Width           =   8715
      Begin VB.OptionButton optCriterio 
         Caption         =   "&Alfabético"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   3
         Left            =   360
         TabIndex        =   5
         Top             =   250
         Value           =   -1  'True
         Width           =   1275
      End
      Begin VB.OptionButton optCriterio 
         Caption         =   "Número de &D.I."
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   1
         Left            =   2722
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   250
         Width           =   2500
      End
      Begin VB.OptionButton optCriterio 
         Caption         =   "&Consecutivo Cliente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   5760
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   250
         Width           =   1935
      End
      Begin VB.OptionButton optCriterio 
         Caption         =   "Pasapo&rte"
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   2
         Left            =   8040
         TabIndex        =   14
         TabStop         =   0   'False
         Top             =   2000
         Visible         =   0   'False
         Width           =   555
      End
   End
   Begin Threed.SSPanel lblEtiqueta 
      Height          =   225
      Index           =   2
      Left            =   2055
      TabIndex        =   19
      Top             =   1830
      Visible         =   0   'False
      Width           =   705
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   15
      Caption         =   "Oficina:"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   27
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   0
      BorderWidth     =   0
      BevelOuter      =   0
      RoundedCorners  =   0   'False
      ShadowColor     =   1
      Alignment       =   1
   End
   Begin VB.TextBox txtOficinaOpt 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2715
      MaxLength       =   4
      TabIndex        =   20
      Top             =   1815
      Visible         =   0   'False
      Width           =   750
   End
   Begin VB.Label lblDesOficina 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   3480
      TabIndex        =   21
      Top             =   1815
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.Label il_titulo02 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   15
      TabIndex        =   17
      Top             =   3780
      Visible         =   0   'False
      Width           =   9420
   End
End
Attribute VB_Name = "FBuscarCliente"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*********************************************************
'   Archivo:        FBUSCLI.FRM
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
' Forma: FBuscarCliente
' Descripción: Esta forma resuelve la búsqueda de Clientes
'              tipo Compañía y Persona, y permite del resul-
'              tado de la búsqueda escoger los datos corres-
'              pondientes a un cliente.  La forma de comuni-
'              cación con la rutina desde la cual fue llama-
'              da esta búsqueda es a través del Arreglo de
'              Strings VGBusqueda() el cual debe ser decla-
'              rado en el módulo global de la aplicación en
'              la que esta forma se utiliza.
'              Si un cliente fue escogido -> VGBusqueda(1) <> ""
'              Si no se escogió cliente -> VGBusqueda(1) = ""
'              VGBusqueda(0) = "P"/"C"
'              Los option buttoms que gobiernan el tipo de cliente
'              a buscar son
'              optCliente(0) -> Busqueda de Persona
'              optCliente(1) -> Busqueda de Compañía
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'           VGBusqueda()        arreglo global que guarda
'                               en forma temporal los campos
'                               del registro seleccionado
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
'*********************************************************

'Variables Locales
Dim VLcriterio%, VLCriterio_soc%, VLCliente%
Dim VLNumLin As Integer

Private Sub cmdBuscar_Click(Index As Integer)
    '******************************************************************************************
    'Objetivo:  Rutinas para buscar clientes de acuerdo al tipo, criterio y valor inicial dados
    '           Estas rutinas sirven a los botones Buscar y Siguientes
    'Input   :  Index       identifica al botón.
    'Output  :  ninguno
    '******************************************************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '01/Nov/93  M.Davila            Emisión Inicial
    '17/Abr/98   R. Castellanos REC  Standarización a COBIS MACOSA Se clasifica la consulta de
    '                               clientes y entes para sp_se_ente debido a
    '                               personalizacion BANESTADO
    '29/Sep/99  J. Loyo             MAnejo de Ancho en el grid funcion PMAnchoColGrid
    '*********************************************************
    Dim VTCriterio$
    Dim VTModo%
    Dim VTsp$
    Dim VTParametro As String
    Dim VTTope&
    Dim nombreCompleto$
    If OptionProspecto.Value = True Then
        VTsp$ = "sp_prospectos_ofi"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1318"
    ElseIf OptionCliente.Value = True Then
        VTsp$ = "sp_se_ente"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1182"
         PMPasoValores sqlconn&, "@i_subgrupo", 0, SQLINT1&, "1"       'REC
    ElseIf OptionAmbos.Value = True Then
        VTsp$ = "sp_se_ente_ofi"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1241" ' "1182"
    Else
        MsgBox "Debe escoger alguna opción en Buscar"
        Exit Sub
    End If

    If txtOficinaOpt.Text <> "" Then
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2&, txtOficinaOpt.Text
    End If
     'PMPasovalores SqlConn&, "@t_trn", 0, SQLINT2&, "1182"
     
    'Se elimina el % del valor de búsqueda
    If InStr(1, txtValor.Text, "%") <> 0 Then
        VTParametro = Left$(txtValor.Text, Len(txtValor.Text) - 1)
    Else
        VTParametro = txtValor.Text
    End If
    
    If optCliente(0).Value Then 'persona
         PMPasoValores sqlconn&, "@i_subtipo", 0, SQLCHAR&, "P"
    Else                        'compañia
         PMPasoValores sqlconn&, "@i_subtipo", 0, SQLCHAR&, "C"
    End If
    
    'Determinar Criterio de Búsqueda -> parámetro @i_tipo
    If optCriterio(0).Value Then 'Codigo
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "1"
         If VTParametro = "" Then
            VTParametro = 0
        End If
        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, (VTParametro)
        VTCriterio$ = "C"
    ElseIf optCriterio(1).Value Then  'Cedula/Ruc
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "2"
        If VTParametro = "" Then
            VTParametro = " "
        End If
        PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR&, (VTParametro)
        VTCriterio$ = "R"
    ElseIf optCriterio(2).Value Then
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "3"
        If VTParametro = "" Then
             VTParametro = " "
        End If
        PMPasoValores sqlconn&, "@i_pasaporte", 0, SQLVARCHAR&, (VTParametro)
        VTCriterio$ = "P"
    Else  'Alfabético
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "4"
        If VTParametro = "" Then
            VTParametro = " "
        End If
        PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, (VTParametro)
        VTCriterio$ = "A"
    End If
        'End If
    'End If

       
    'Buscar los 20 primeros o los siguientes
    Select Case Index
        Case 0  '20 primeros
            VTModo% = False
            VLNumLin = 0
            'PMPasoValores SqlConn&, "@i_ente", 0, SQLINT4&, (VTParametro)
            'Determinar Valor de búsqueda
            If InStr(1, txtValor.Text, "%") = 0 Then
                'buscar un valor específico
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "2"
            Else
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
            End If

        Case 1  'siguientes
            VTModo% = True
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
            grdResultados.Row = grdResultados.Rows - 1
            VTTope& = grdResultados.Row
            Select Case VTCriterio$
                Case "A"
                    grdResultados.Col = 2
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                    nombreCompleto$ = Trim$(grdResultados.Text) + " "
                    If optCliente(0).Value Then 'persona
                         PMPasoValores sqlconn&, "@i_p_apellido", 0, SQLVARCHAR&, (grdResultados.Text)
                        grdResultados.Col = 3
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                        nombreCompleto$ = Trim$(nombreCompleto$ + Trim$(grdResultados.Text)) + " "
                         PMPasoValores sqlconn&, "@i_s_apellido", 0, SQLVARCHAR&, (grdResultados.Text)
                        grdResultados.Col = 4
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                        nombreCompleto$ = nombreCompleto$ + Trim$(grdResultados.Text)
                         PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, (grdResultados.Text)
                         PMPasoValores sqlconn&, "@i_nombre_completo", 0, SQLVARCHAR&, (nombreCompleto$)
                    Else  'compania
                         PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, (grdResultados.Text)
                    End If

                Case "C"     'codigo
                    grdResultados.Col = 1
                     PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, (grdResultados.Text)

                Case "R"     'cedula o ruc
                    If optCliente(0).Value Then 'persona
                        grdResultados.Col = 5
                    Else  'compañia
                        grdResultados.Col = 3
                    End If
                     PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLCHAR&, (grdResultados.Text)

                Case "P"
                    grdResultados.Col = 8
                     PMPasoValores sqlconn&, "@i_pasaporte", 0, SQLCHAR&, (grdResultados.Text)
            End Select
    End Select
'     PMPasoValores SqlConn&, "@i_valor", 0, SQLVARCHAR&, (txtValor.Text)
    
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", VTsp$, True, "Búsqueda de Clientes") Then
'     If FMTransmitirRPC(sqlconn&, FMGetServer(), "cobis", VTsp$, True, "Búsqueda de Clientes") Then
         PMMapeaGrid sqlconn&, grdResultados, VTModo%
        If optCliente(0).Value = True Then 'persona
            grdResultados.Cols = 11
            PMAnchoColGrid grdResultados, 1 'consecutivo
            PMAnchoColGrid grdResultados, 2 'p.apellido
            PMAnchoColGrid grdResultados, 3 's.apellido
            PMAnchoColGrid grdResultados, 4 'nombre
            PMAnchoColGrid grdResultados, 5 'D.I.
            PMAnchoColGrid grdResultados, 6 'tipo D.I.
            PMAnchoColGrid grdResultados, 7 'Fecha de Nacimiento
            PMAnchoColGrid grdResultados, 8 'Gerente
            PMAnchoColGrid grdResultados, 9 'Mala Referencia
            PMAnchoColGrid grdResultados, 10 'Categoria
        Else                        'compañia
            grdResultados.Cols = 9
            PMAnchoColGrid grdResultados, 1 'consecutivo
            PMAnchoColGrid grdResultados, 2 'nombre/cia
            PMAnchoColGrid grdResultados, 3 'nit/ D.I.
            PMAnchoColGrid grdResultados, 4 'tipo DI
            PMAnchoColGrid grdResultados, 5 'Mala Referencia
            PMAnchoColGrid grdResultados, 6 'Fecha de Constitución.
            PMAnchoColGrid grdResultados, 7 'Gerente
            PMAnchoColGrid grdResultados, 8 'Categoria.
        End If
        
         PMChequea sqlconn&
        If Val(grdResultados.Tag) >= (VGMaximoRows% - 1) Then
            cmdBuscar(1).Enabled = True
            If VTModo% = True Then
                If grdResultados.Rows > VGMaximoRows% Then
                    grdResultados.TopRow = VTTope&   'grdValores.Rows - MaximoRows% - 2
                End If
            End If
        Else
            If VTModo% = True Then
                cmdBuscar(1).Enabled = False 'si no funciona se quita esta linea
                'If grdResultados.Tag > 0 Then
                '    grdResultados.TopRow = grdResultados.Rows - VGMaximoRows% - 1
                'End If
            End If
            
            'cmdBuscar(1).Enabled = False
        End If
    End If
End Sub

Private Sub cmdBuscar_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  Index       identifica al botón
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Select Case Index
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Buscar Clientes de acuerdo a especificaciones"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Buscar el siguiente grupo de Clientes"
    End Select
End Sub

Private Sub cmdEscoger_Click()
'*********************************************************
'Objetivo:  Esta rutina guarda el contenido de la línea
'           del grid escogida en el arreglo global VGBusqueda()
'           del cual, al salir de la forma, se pueden
'           extraer los datos de un cliente.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'15/Oct/96  s.Meza              Habilitar busqueda clientes
'                               por compañias
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
        ReDim VGBusqueda(0 To VTCols% + 1)
        If optCliente(0).Value = True Then 'persona
            VGBusqueda(0) = "P"
        Else
            VGBusqueda(0) = "C" 'compañía
        End If
        For i% = 1 To grdResultados.Cols - 1
            grdResultados.Col = i%
            VGBusqueda(i%) = grdResultados.Text
        Next i%
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        If FBuscarCliente.Tag <> "C" Then
            FBuscarCliente.Hide
        End If
    End If
    optCliente(1).Enabled = True

End Sub

Private Sub cmdEscoger_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Escoger un Cliente"
End Sub

Private Sub cmdSalir_Click()
'*********************************************************
'Objetivo:  Inicializa el arreglo global VGBusqueda y ocul-
'           ta la forma. (No la descarga)
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'15/Oct/96  S.Meza              Habilitar Busqueda por
'                               Compañias
'*********************************************************
    ReDim VGBusqueda(1)
    optCliente(1).Enabled = True
    cmdEscoger.Visible = True      'REC033
    optCliente(0).Enabled = True   'REC034
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
    FBuscarCliente.Hide
End Sub

Private Sub cmdSalir_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Salir de la Forma de Búsqueda"
End Sub

Private Sub Form_Activate()
Dim VGOnline As Boolean
    PMLimpiaGrid grdResultados
    txtOficinaOpt.Text = ""
    lblDesOficina.Caption = ""
    OptionProspecto.Value = False
    OptionCliente.Value = True
    If VGOnline = False Then
        OptionAmbos.Value = True
        OptionCliente.Enabled = False
        OptionProspecto.Enabled = False
        OptionAmbos.Enabled = False
    End If

End Sub

Private Sub Form_Load()
Dim VGOnline As Boolean
If VGOnline = False Then
    OptionAmbos.Value = True
    OptionCliente.Enabled = False
    OptionProspecto.Enabled = False
    OptionAmbos.Enabled = False
End If
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
    VLcriterio% = 0      'criterio de busq. para persona/sociedad
    VLCriterio_soc% = 0  'criterio de busq. para sociedad de hecho
    VLNumLin = 0
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
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlTransaccionLine.Caption = ""
    If FBuscarCliente.Tag = "C" Then 'entro por el menu de consulta y no de busqueda
       FPrincipal.pnlHelpLine.Caption = ""
    Else
       FPrincipal.pnlHelpLine.Caption = "Doble-click para Escoger un Cliente"
    End If
End Sub

Private Sub optCliente_Click(Index As Integer)
Dim Value As Integer
Value = optCliente(Index).Value
optCliente_ClickHelper Index, Value
End Sub
Private Sub optCliente_ClickHelper(Index As Integer, Value As Integer)
    '*********************************************************
    'Objetivo:  Sirve para seleccionar el tipo de cliente a
    '           buscar: Personas o Compañías. Según el tipo
    '           de cliente habilita los criterios apropiados.
    '           Cuando el tipo de cliente cambia, limpia el
    '           grid de resultados
    'Input   :  Index       identifica al option buttom
    '                       0 Persona / 1 Compañía
    'Output  :  ninguno
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '01/Nov/93  M.Davila            Emisión Inicial
    '*********************************************************
    Select Case Index
        Case 0  'Persona
            If Value = True Then
                If VLCliente% = 1 Then 'estaba seleccionada compañía
                    VLCliente% = 0
                    PMLimpiaG grdResultados
                    cmdBuscar(1).Enabled = False
                End If
                optCriterio(2).Enabled = True
                optCriterio(2).Caption = "Pasapo&rte"
                optCriterio(1).Caption = "Número de &D.I."
            End If

        Case 1  'Compañía
            If Value = True Then
                If VLCliente% = 0 Then 'estaba seleccionada persona
                    VLCliente% = 1
                    PMLimpiaG grdResultados
                    cmdBuscar(1).Enabled = False
                End If
                optCriterio(2).Caption = "Pasapo&rte"
                'OptCriterio(2).Enabled = False
                optCriterio(1).Caption = "Número de &D.I."
                optCriterio(2).Enabled = False
                If optCriterio(2).Value = True Then
                    optCriterio(3).Value = True
                End If
            End If

        Case 2  'Sociedades de Hecho
           optCriterio(2).Enabled = True
           optCriterio(2).Caption = "&Tipo"
           optCriterio(1).Caption = "&NIT"
            If Value = True Then
               VLCliente% = 2
               PMLimpiaG grdResultados
               cmdBuscar(1).Enabled = False
            End If
    End Select
End Sub

Private Sub optCliente_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  Index       identifica al option buttom
'                       0 Persona / 1 Compañía
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Seleccionar el Tipo de Cliente que se desea Buscar"
End Sub

Private Sub optCriterio_Click(Index As Integer)
Dim Value As Integer
Value = optCriterio(Index).Value
optCriterio_ClickHelper Index, Value
End Sub
Private Sub optCriterio_ClickHelper(Index As Integer, Value As Integer)
    '*********************************************************
    'Objetivo:  Nos permite escoger un criterio de búsqueda
    '           de clientes. Cuando el criterio cambia, ini-
    '           cializa el campo con el valor inicial a "%"
    'Input   :  Index       identifica al option buttom.
    '                       0 Código | 1 Cedula o RUC |
    '                       2 Pasaporte | 3 Alfabético
    'Output  :  ninguno
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '01/Nov/93  M.Davila            Emisión Inicial
    '*********************************************************
    Select Case Index
        Case 0  'Código
            If Value = True Then
                If VLcriterio% <> 0 Then 'estaba seleccionado otro criterio
                    VLcriterio% = 0
                    txtValor.Text = "%"
                    cmdBuscar(1).Enabled = False
                End If
            End If

        Case 1  'D.I./NIT
            If Value = True Then
                If VLcriterio% <> 1 Then 'estaba seleccionado otro criterio
                    VLcriterio% = 1
                    txtValor.Text = "%"
                    cmdBuscar(1).Enabled = False
                End If
            End If

        Case 2  'Pasaporte
            If Value = True Then
                If VLcriterio% <> 2 Then 'estaba seleccionado otro criterio
                    VLcriterio% = 2
                    txtValor.Text = "%"
                    cmdBuscar(1).Enabled = False
                End If
            End If

        Case 3  'Alfabético
            If Value = True Then
                If VLcriterio% <> 3 Then 'estaba seleccionado otro criterio
                    VLcriterio% = 3
                    txtValor.Text = "%"
                    cmdBuscar(1).Enabled = False
                End If
            End If
    End Select
End Sub

Private Sub optCriterio_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  Index       identifica al option buttom
'                       0 Codigo | 1 Cedula 0 RUC
'                       2 Pasaporte | 3 Alfabético
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Seleccionar el Criterio de Búsqueda"
End Sub


Private Sub txtOficinaOpt_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'03/Ene/97  J. Loyo H.          Emisión Inicial
'*********************************************************
    Dim VLPaso%
    VLPaso% = True
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = "Código de la Oficina [F5] Ayuda"
    txtOficinaOpt.SelStart = 0
    txtOficinaOpt.SelLength = Len(txtOficinaOpt.Text)
End Sub

Private Sub txtOficinaOpt_KeyDown(KeyCode As Integer, Shift As Integer)
'If KeyCode = F5% Then
        'consulta de oficina
'        VLPaso% = True
 '        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR&, "H"
 '        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR&, "AL"
 '        PMPasoValores SqlConn&, "@i_modo", 0, SQLINT1&, "0"
'        'codigo de transaccion
 '        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2&, "1574"
'        PMHelpG "cobis", "sp_oficina", 4, 1
 '        PMBuscarG 1, "@i_operacion", "H", SQLCHAR&
 '        PMBuscarG 2, "@i_tipo", "AL", SQLCHAR&
 '        PMBuscarG 3, "@i_modo", "0", SQLINT1&
 '        PMBuscarG 4, "@t_trn", "1574", SQLINT2&
 '        PMSigteG 1, "@i_oficina", 1, SQLINT2&
 '        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_oficina", True, "Ayuda Ciudad") Then
 '            PMMapeaGrid SqlConn&, grid_valores.gr_SQL, False
 '            PMChequea SqlConn&
'            PMProcesG
'            grid_valores.Show 1
'            If Temporales(1) <> "" Then
'                DoEvents
'                txtoficinaOpt.Text = Temporales(1)
'                lbldesoficina.Caption = Temporales(2)
'                VLPaso% = True
'                SendKeys "{TAB}"
'            Else
'                VLPaso% = False
'                txtOficinaOpt_LostFocus
'                If txtoficinaOpt.Text = "" Then
'                    lbldesoficina.Caption = ""
'                End If
'            End If
'        End If
'End If

'/****/
Dim VLPaso%
If KeyCode = VGTeclaAyuda% Then
        VLPaso% = True
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "cl_oficina"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMHelpG "cobis", "sp_hp_catalogo", 3, 0
         PMBuscarG 1, "@i_tabla", "cl_oficina", SQLCHAR&
         PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
         PMBuscarG 3, "@i_modo", "0", SQLINT1&
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
             PMMapeaGrid sqlconn&, grid_valores.gr_SQL, False
             PMChequea sqlconn&
            PMProcesG
            grid_valores.Show 1
            If Temporales(1) <> "" Then
                DoEvents
                txtOficinaOpt.Text = Temporales(1)
                lblDesOficina.Caption = Temporales(2)
                VLPaso% = True
                SendKeys "{TAB}"
            Else
                VLPaso% = False
                txtOficinaOpt_lostfocus
            End If
        End If
End If
End Sub

Private Sub txtOficinaOpt_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea alfanumerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'03/Ene/97  J. Loyo H.          Emisión Inicial
'*********************************************************
    
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If

End Sub

Private Sub txtOficinaOpt_lostfocus()
'If Not VLPaso% Then
'     If txtOficinaOpt.Text <> "" Then
'        'consulta de oficina
'            txtOficinaOpt.Text = Trim$(txtOficinaOpt.Text)
 '            PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR&, "H"
 '            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR&, "VL"
 '            PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT2&, (txtOficinaOpt.Text)
'            'codigo de transaccion
 '            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2&, "1574"
 '            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_oficina", True, "Ayuda Oficina") Then
 '               PMMapeaObjeto SqlConn&, lblDesOficina
 '               PMChequea SqlConn&
'            Else
'               txtOficinaOpt.Text = ""
'               lblDesOficina.Caption = ""
'              If txtOficinaOpt.Enabled Then
'               txtOficinaOpt.SetFocus
'              End If
'            End If
'
'     Else
'        lblDesOficina.Caption = ""
'     End If
'
'End If
Dim VLPaso%
    If Not VLPaso% Then
        txtOficinaOpt.Text = Trim$(txtOficinaOpt.Text)
        If txtOficinaOpt.Text <> "" Then
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "cl_oficina"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtOficinaOpt.Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                 PMMapeaObjeto sqlconn&, lblDesOficina
                 PMChequea sqlconn&
            Else
                txtOficinaOpt.Text = ""
                lblDesOficina.Caption = ""
            End If
        End If
    Else
        txtOficinaOpt.Text = Trim$(txtOficinaOpt.Text)
    End If
    If txtOficinaOpt.Text = "" And lblDesOficina.Caption <> "" Then
        lblDesOficina.Caption = ""
    End If

End Sub

Private Sub txtValor_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
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
'22/jun/00  C.Espinel           Corrección de búsqueda de clientes
'*********************************************************

If optCriterio(0).Value = True Then
    If (KeyAscii% < 48 Or KeyAscii% > 57) And KeyAscii% <> 37 And KeyAscii% <> 8 Then
        KeyAscii% = 0
    End If
Else
    If optCriterio(1).Value = True Then
        If KeyAscii% = 8 Or (KeyAscii% >= 48 And KeyAscii% <= 57) Or (KeyAscii% >= 65 And KeyAscii% <= 90) Or (KeyAscii% >= 97 And KeyAscii% <= 122) Or KeyAscii% = 37 Then
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        Else
            KeyAscii% = 0
        End If
    Else
        If optCriterio(2).Value = True Then
            If KeyAscii% = 8 Or (KeyAscii% >= 48 And KeyAscii% <= 57) Or (KeyAscii% >= 65 And KeyAscii% <= 90) Or (KeyAscii% >= 97 And KeyAscii% <= 122) Or KeyAscii% = 37 Or KeyAscii% = 45 Then
                KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
            Else
                KeyAscii% = 0
            End If
        Else
            If optCriterio(3).Value = True Then
                If KeyAscii% = 8 Or (KeyAscii% >= 32 And KeyAscii% <= 122) Then
                    KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
                Else
                    KeyAscii% = 0
                End If
            End If
        End If
    End If
End If

End Sub

Private Sub txtValor_LostFocus()
'*********************************************************
'Objetivo:  Elimina blancos a izquierda y derecha
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
Dim VTTam%
Dim VTPos%
Dim VTParametro$
    txtValor.Text = Trim$(UCase$((txtValor.Text)))
    VTTam% = Len(txtValor.Text)
    VTPos% = InStr(1, txtValor, "%")
    
    If ((VTPos% > 1) And (VTPos% <> VTTam%)) Or ((VTTam% > 1) And (VTPos% = 1)) Then
        MsgBox "Criterio de Búsqueda inválido, utilice caracter % solo al final del valor de búsqueda", 48, "Control Ingreso de Datos"
        txtValor.Text = "%"
        txtValor.SetFocus
        Exit Sub
    End If
    If Len(txtValor.Text) > 0 Then
        VTParametro$ = Left$(txtValor.Text, Len(txtValor.Text) - 1)
    Else
        VTParametro = ""
    End If
    'JAN MAY/00
    If optCriterio(0).Value = True Then
        If Val(VTParametro$) > 999999999 Then
            MsgBox "El código no puede ser mayor a 999,999,999", 48, "Control Ingreso de Datos"
            txtValor.Text = "%"
            txtValor.SetFocus
            Exit Sub
        End If
    End If
'ELA MAR/2001 BUSCA ALFANUMERICA EN TODOS LOS CASOS
'    If optCriterio(1).Value = True Then
'        Dim VTNuip(2, 20) As String
'        VTPosi% = 0
'        For j = 1 To (VTTam% - 1)
'            VTNuip(1, j) = Mid(txtValor.Text, j, 1)
'            If Asc(VTNuip(1, j)) >= 48 And Asc(VTNuip(1, j)) <= 57 Then
'                VTNuip(2, j) = "N"
'            Else
'                VTNuip(2, j) = "C"
'                VTPosi% = j
'            End If
'        Next
'        If VTPosi% > 3 Then
'            MsgBox "Número de identificación incorrecto", 48, "Control Ingreso de Datos"
'            txtValor.Text = "%"
'            txtValor.SetFocus
'            Exit Sub
'        Else
'            If VTPosi% <= 3 And VTPosi% <> 0 Then
'                VTEsNuip$ = "S"
'                For k = 1 To 3
'                    If VTNuip(2, k) = "C" And VTEsNuip$ = "S" Then
'                        VTEsNuip$ = "S"
'                    Else
'                        VTEsNuip$ = "N"
'                    End If
'                Next
'                If VTEsNuip$ = "N" Then
'                    MsgBox "Número de identificación incorrecto", 48, "Control Ingreso de Datos"
'                    txtValor.Text = "%"
'                    txtValor.SetFocus
'                    Exit Sub
'                End If
'            End If
'        End If
        
        If Len(VTParametro$) > 16 Then
            MsgBox "La longitud del Documento de Identificación puede ser mayor de 16 caracteres", 48, "Control Ingreso de Datos"
            txtValor.Text = "%"
            txtValor.SetFocus
            Exit Sub
        End If
'    End If
    
End Sub



