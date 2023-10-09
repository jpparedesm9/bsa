VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FConCarTasas 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Características de Tasa"
   ClientHeight    =   5325
   ClientLeft      =   585
   ClientTop       =   2100
   ClientWidth     =   9300
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
   HelpContextID   =   200
   Icon            =   "FConCTa.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.Frame fraValor 
      ForeColor       =   &H000000FF&
      Height          =   765
      Left            =   2490
      TabIndex        =   7
      Top             =   60
      Width           =   5805
      Begin TxtinLib.TextValid txtValor 
         Height          =   285
         Left            =   180
         TabIndex        =   0
         Top             =   270
         Width           =   5475
         _Version        =   65536
         _ExtentX        =   9657
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "%"
         ForeColor       =   -2147483640
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   0
         Character       =   0
         Type            =   4
         HelpLine        =   "Valor de Búsqueda de Tasa"
         Pendiente       =   ""
         Connection      =   1
         AsociatedLabelIndex=   24396
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
   End
   Begin VB.Frame fraTasas 
      Caption         =   "Criterios de Búsqueda"
      ForeColor       =   &H000000FF&
      Height          =   765
      Left            =   60
      TabIndex        =   6
      Top             =   60
      Width           =   2415
      Begin VB.OptionButton optCriterio 
         Caption         =   "Nombre"
         Height          =   285
         Index           =   1
         Left            =   1080
         TabIndex        =   9
         Top             =   270
         Width           =   1155
      End
      Begin VB.OptionButton optCriterio 
         Caption         =   "Código"
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   8
         Top             =   270
         Value           =   -1  'True
         Width           =   1155
      End
   End
   Begin MSGrid.Grid grdGTasas 
      Height          =   4155
      Left            =   60
      TabIndex        =   1
      Top             =   1170
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   7329
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
      Left            =   8415
      TabIndex        =   2
      Top             =   15
      WhatsThisHelpID =   2000
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
      Picture         =   "FConCTa.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   1
      Left            =   8415
      TabIndex        =   3
      Top             =   885
      WhatsThisHelpID =   2020
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
      Enabled         =   0   'False
      Picture         =   "FConCTa.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   4
      Left            =   8400
      TabIndex        =   4
      Top             =   4440
      WhatsThisHelpID =   2008
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
      Picture         =   "FConCTa.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   5
      Left            =   8415
      TabIndex        =   10
      Top             =   3600
      WhatsThisHelpID =   2002
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
      Picture         =   "FConCTa.frx":035E
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Características de Tasas:"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   30
      TabIndex        =   5
      Top             =   900
      Width           =   2205
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5295
   End
End
Attribute VB_Name = "FConCarTasas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FCONCTA.FRM
'   Producto:       Subsistema de Referencias del Sistema
'   Diseñado por:   Roberth Minga Vallejo
'   Fecha de Documentación: 16/May/00
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
' RMI16May00: Consulta para caracteristicas de tasas
'*********************************************************

Private Sub cmdBoton_Click(Index As Integer)
Select Case Index%
  
  Case 0 'Buscar
     'Paso de parametros de búsqueda
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15193"
     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
     
     'Si el criterio es por código de tasa pasar los parámetros adecuados
     If optCriterio(0).Value = True Then
        PMPasoValores sqlconn&, "@i_criterio", 0, SQLCHAR&, "C"
        PMPasoValores sqlconn&, "@i_tasa", 0, SQLCHAR&, txtValor.Text
     End If
     
     'Si el criterio es por descripción de tasa pasar los parámetros adecuados
     If optCriterio(1).Value = True Then
        PMPasoValores sqlconn&, "@i_criterio", 0, SQLCHAR&, "D"
        PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR&, txtValor.Text
     End If
     
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tare_car_tasa", True, "") Then
         PMMapeaGrid sqlconn&, grdGTasas, False
         PMChequea sqlconn&
         If Val(grdGTasas.Tag) = 20 Then
            cmdBoton(1).Enabled = True
         Else
            cmdBoton(1).Enabled = False
        End If
    End If
        'JLO 2001/10/02 Cambio para que la escoger el primer registro
        grdGTasas.Row = 1
        grdGTasas_Click
        
 Case 1  'Siguiente
    If Val(grdGTasas.Tag) > 0 Then
        grdGTasas.Row = grdGTasas.Rows - 1
        
        'Paso de parámetros de búsqueda para siguientes registros
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15193"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
        
        'Si el criterio es por código de tasa
        If optCriterio(0).Value = True Then
           PMPasoValores sqlconn&, "@i_criterio", 0, SQLCHAR&, "C"
           PMPasoValores sqlconn&, "@i_tasa", 0, SQLCHAR&, txtValor.Text
           grdGTasas.Col = 1
           PMPasoValores sqlconn&, "@i_tasa_sig", 0, SQLCHAR&, grdGTasas.Text
           grdGTasas.Col = 2
           PMPasoValores sqlconn&, "@i_periodo", 0, SQLINT2&, grdGTasas.Text
           grdGTasas.Col = 3
           PMPasoValores sqlconn&, "@i_modalidad", 0, SQLCHAR&, grdGTasas.Text
        End If
        
        'Si el criterio es por descripción de tasa
        If optCriterio(1).Value = True Then
           PMPasoValores sqlconn&, "@i_criterio", 0, SQLCHAR&, "D"
           PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR&, txtValor.Text
           grdGTasas.Col = 4
           PMPasoValores sqlconn&, "@i_descripcion_sig", 0, SQLCHAR&, grdGTasas.Text
           grdGTasas.Col = 2
           PMPasoValores sqlconn&, "@i_periodo", 0, SQLINT2&, grdGTasas.Text
           grdGTasas.Col = 3
           PMPasoValores sqlconn&, "@i_modalidad", 0, SQLCHAR&, grdGTasas.Text
        End If
        
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tare_car_tasa", True, "") Then
           PMMapeaGrid sqlconn&, grdGTasas, True
           PMChequea sqlconn&

           If Val(grdGTasas.Tag) = 20 Then
               cmdBoton(Index%).Enabled = True
           Else
               cmdBoton(Index).Enabled = False
           End If
        End If
    End If
        'JLO 2001/10/02 Cambio para que la escoger el primer registro
        grdGTasas.Row = 1
        grdGTasas_Click
        
    Case 4  ' Salir
        Unload Me

    Case 5  'Escoger
        grdGTasas.Col = 1
        If grdGTasas.Text <> "" Then
           Temporales(1) = grdGTasas.Text
           grdGTasas.Col = 2
           Temporales(2) = grdGTasas.Text
           grdGTasas.Col = 3
           Temporales(3) = grdGTasas.Text
           grdGTasas.Col = 4
           Temporales(4) = grdGTasas.Text
           grdGTasas.Col = 5
           Temporales(5) = grdGTasas.Text
           grdGTasas.Col = 6
           Temporales(6) = grdGTasas.Text
           grdGTasas.Col = 7
           Temporales(7) = grdGTasas.Text
        Else
           Temporales(1) = ""
           Temporales(2) = ""
           Temporales(3) = ""
           Temporales(4) = ""
           Temporales(5) = ""
           Temporales(6) = ""
           Temporales(7) = ""
        End If
        Unload Me
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de Tasas Referenciales"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de las siguientes Tasas"
    Case 4
        FPrincipal.pnlHelpLine.Caption = "Salir de la Forma"
    Case 5
        FPrincipal.pnlHelpLine.Caption = "Escoger la Tasa Referencial"
    End Select

End Sub
Private Sub Form_Load()

' CV 06/10/2000 declaración de sentencias
    PMLoadResStrings Me
    PMLoadResIcons Me
' CV 06/10/2000 declaración de sentencias
    Me.Top = 1040
    Me.Left = 90
    Me.Width = 9420
    Me.Height = 5730
    cmdBoton_Click (0)
    'Habilitar botones dependiendo del uso que se le da a la forma
    'ya sea consulta o mantenimiento de tasas
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdGTasas_Click()
    If grdGTasas.Rows >= 2 Then
        If grdGTasas.Row > 0 Then
            grdGTasas.Col = 0
            grdGTasas.SelStartCol = 1
            grdGTasas.SelEndCol = grdGTasas.Cols - 1
            grdGTasas.SelStartRow = grdGTasas.Row
            grdGTasas.SelEndRow = grdGTasas.Row
        End If
    End If

End Sub

Private Sub grdGTasas_DblClick()
    If Val(grdGTasas.Tag) > 0 Then
           cmdBoton_Click (5)
    End If
End Sub

Private Sub grdGTasas_GotFocus()
        FPrincipal.pnlHelpLine.Caption = "Tasas Referenciales existentes"
End Sub

Private Sub txtValor_LostFocus()
   Dim i As Integer
   
   'Evaluar si existe el caracter %
   For i% = 1 To Len(txtValor.Text)
      If Mid(txtValor, i%, 1) = "%" Then
         Exit Sub
      End If
   Next i%
   
   'Si no existe el caracter % colocarlo en el valor
   txtValor.Text = txtValor.Text + "%"
End Sub

