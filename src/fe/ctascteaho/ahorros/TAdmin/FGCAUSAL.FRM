VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FBusCausal 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Listado General de Causales"
   ClientHeight    =   4440
   ClientLeft      =   540
   ClientTop       =   330
   ClientWidth     =   8370
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
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FGCAUSAL.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4440
   ScaleWidth      =   8370
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2430
      MaxLength       =   30
      TabIndex        =   2
      Text            =   "%"
      Top             =   495
      Width           =   4860
   End
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   1
      Left            =   690
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   645
      Width           =   1305
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Nombre"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   27
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   0
      Left            =   690
      TabIndex        =   0
      Top             =   390
      Width           =   1305
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Código"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   27
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSGrid.Grid grdCausales 
      Height          =   3210
      Left            =   0
      TabIndex        =   3
      Top             =   1215
      Width           =   7365
      _Version        =   65536
      _ExtentX        =   12992
      _ExtentY        =   5662
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   0
      Left            =   7440
      TabIndex        =   4
      Tag             =   "15044"
      Top             =   15
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FGCAUSAL.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   1
      Left            =   7440
      TabIndex        =   5
      Top             =   885
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Si&guiente"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FGCAUSAL.frx":0680
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   4
      Left            =   7440
      TabIndex        =   8
      Top             =   3540
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FGCAUSAL.frx":08C2
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   2
      Left            =   7440
      TabIndex        =   6
      Tag             =   "15042"
      Top             =   2205
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Escoger"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FGCAUSAL.frx":0C38
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   3
      Left            =   7440
      TabIndex        =   7
      Tag             =   "542"
      Top             =   2205
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Eliminar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FGCAUSAL.frx":0FAE
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "[Código] : "
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4155
      TabIndex        =   12
      Top             =   150
      Width           =   900
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Valor de Búsqueda "
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   2460
      TabIndex        =   11
      Top             =   150
      Width           =   1680
   End
   Begin VB.Line linLinea 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   2295
      X2              =   2295
      Y1              =   15
      Y2              =   975
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Condición de Búsqueda :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   10
      Top             =   135
      Width           =   2145
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Causales :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   9
      Top             =   1005
      Width           =   900
   End
   Begin VB.Line linLinea 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   7410
      Y1              =   990
      Y2              =   990
   End
   Begin VB.Line linLinea 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   7410
      X2              =   7410
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FBusCausal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FBusCausal.FRM
'   Producto:       Subsistema de Seguridad
'   Diseñado por:   Fabián Espinosa
'   Fecha de Documentación: 08/Feb/94
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
' Forma:    FBusCausal
' Descripcion:  Forma de busqueda de Causales
'*************************************************************
'
'                       MODIFICACIONES
' FECHA             AUTOR                      RAZON
'*************************************************************
'
'
'CRA06MAY9801 II: Salía de Aplicación, ingreso de un tiempo
'               de retardo
'


Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0  ' Busqueda
        
        If optOpcion(0).Value = True Then
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "1"
        Else
            If optOpcion(1).Value = True Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "2"
            End If
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VGCatCausal
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
         PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, txtCampo.Text
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "741"

        FPrincipal.pnlTransaccionLine.Caption = ""

         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_caubusq", True, "") Then
             PMMapeaGrid sqlconn&, grdCausales, False
             PMChequea sqlconn&
            If Val(grdCausales.Tag) > MaximoRows% Then
                cmdBoton(1).Enabled = True
            Else
                cmdBoton(1).Enabled = False
            End If
        Else
            PMLimpiaGrid grdCausales
        End If
    
    Case 1  ' Siguientes

        If Val(grdCausales.Tag) > 0 Then
    
            grdCausales.Row = grdCausales.Rows - 1
            VTTope% = grdCausales.Row
            If optOpcion(0).Value = True Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "1"
                grdCausales.Col = 1
                 PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR&, grdCausales.Text
            Else
                If optOpcion(1).Value = True Then
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "2"
                    grdCausales.Col = 2
                     PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR&, grdCausales.Text
                End If
            End If
            
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VGCatCausal
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
             PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, txtCampo.Text
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "741"
    
            FPrincipal.pnlTransaccionLine.Caption = ""

            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_caubusq", True, "") Then
                PMMapeaGrid sqlconn&, grdCausales, True
                PMChequea sqlconn&

                If grdCausales.Tag > MaximoRows% Then
                   PMBotonSeguridad FBusCausal, Index%
                Else
                   cmdBoton(Index%).Enabled = False
                End If
                 
                On Error GoTo ErrorSiguientes
                 
                grdCausales.TopRow = grdCausales.Rows - 13
                    
            Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VTNumeroMensaje$ = Trim(FmMapeaNumMensaje())
                If (VTNumeroMensaje$ = "151121") Then
                    cmdBoton(Index%).Enabled = False
                End If
            End If


        End If
    
    Case 2  ' Escoger
        
        If Val(grdCausales.Tag) > 0 Then

            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "3"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "741"
            grdCausales.Col = 1
            PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, (grdCausales.Text)
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VGCatCausal
            
            FPrincipal.pnlTransaccionLine.Caption = ""
            ReDim Valores(10) As String
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_caubusq", True, "") Then
                VTR% = FMMapeaArreglo(sqlconn&, Valores())
                PMChequea sqlconn&
                VGCausal = Valores(1)
            End If
            txtCampo.Text = "%"                 'ADU: 2001-07-26
            PMLimpiaGrid grdCausales               'ADU: 2001-07-26
            'FBusCausal.Hide
            Unload FBusCausal
            
        End If
       
    Case 4  ' Salir
        PMLimpiaGrid grdCausales       'ADU: 2001-07-26
        Unload FBusCausal
    End Select
Exit Sub
ErrorSiguientes:
    grdCausales.TopRow = 1
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Descripcion de cada Boton
'Input   :  Index%  Indice de cada boton
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de Causales"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de las siguientes Causales"
    Case 2
        FPrincipal.pnlHelpLine.Caption = "Escoger la causal actual"
    Case 4
        FPrincipal.pnlHelpLine.Caption = "Salir de la forma"
    End Select
End Sub


Private Sub Form_Load()
    FBusCausal.Left = 550
    FBusCausal.Top = 1470
    FBusCausal.Height = 4845
    FBusCausal.Width = 8490
    
    PMBotonSeguridad FBusCausal, 0
    PMBotonSeguridad FBusCausal, 2
    PMBotonSeguridad FBusCausal, 3
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCausales_Click()
'*********************************************************
'Objetivo:  Resaltar la linea actual del grid
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    If Val((grdCausales.Tag)) >= 1 Then
        PMLineaG grdCausales
    End If
End Sub

Private Sub grdCausales_DblClick()
    cmdBoton_Click (2)
End Sub

Private Sub grdCausales_GotFocus()
'*********************************************************
'Objetivo:  Descripcion del grid
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    FPrincipal.pnlHelpLine.Caption = "Roles Existentes"

End Sub

Private Sub optOpcion_Click(Index As Integer, Value As Integer)
'*********************************************************
'Objetivo:  Descripcion del valor ha ser ingresado como
'           patron de busqueda
'Input   :  Index% Indice del boton de opcion
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    If optOpcion(Index%).Value = True Then
        lblTitulo(3).Caption = "[" + optOpcion(Index%).Caption + "]"
        txtCampo.Text = "%"
        cmdBoton_Click (0)
        txtCampo.SetFocus
    End If
End Sub

Private Sub optOpcion_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Descripcion de cada Boton
'Input   :  Index%  Indice de cada boton
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Código del Rol"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Nombre del Rol"
    End Select
End Sub

Private Sub txtCampo_GotFocus()
'*********************************************************
'Objetivo:  Descripcion de cada campo
'Input   :  Index% Indice del Campo
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    'Seleccionar el texto a la entrada
    txtCampo.SelStart = 0
    txtCampo.SelLength = Len(txtCampo.Text) - 1
    
    If optOpcion(0).Value = True Then
        FPrincipal.pnlHelpLine.Caption = "Código del Rol"
    Else
        If optOpcion(1).Value = True Then
            FPrincipal.pnlHelpLine.Caption = "Nombre del Rol"
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  Control de los valores permitidos
'Input   :  KeyAscii%   Ascii de la tecla digitada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    If optOpcion(0).Value = True Then
        If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) And (KeyAscii% <> 37) Then
            KeyAscii% = 0
        End If
    Else
        If optOpcion(1).Value = True Then
            If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) And (KeyAscii% <> 37) Then
                KeyAscii% = 0
            Else
                KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
            End If
        End If
    End If
End Sub

Private Sub txtCampo_LostFocus()
'*********************************************************
'Objetivo:  Control para que nunca sea nulo el patron de
'           busqueda
'Input   :  Index% Indice del Campo
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    If txtCampo.Text = "" Then
        txtCampo.Text = "%"
    End If
    FPrincipal.pnlHelpLine.Caption = ""
    txtCampo.Text = Trim$(txtCampo.Text)
End Sub


