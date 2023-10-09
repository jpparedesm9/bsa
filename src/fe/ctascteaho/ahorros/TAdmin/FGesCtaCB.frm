VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Begin VB.Form FGesCtaCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Gestión Cuentas de Corresponsalia"
   ClientHeight    =   5595
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9495
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5595
   ScaleWidth      =   9495
   Begin VB.TextBox txtTran 
      Height          =   285
      Left            =   1785
      TabIndex        =   9
      Top             =   2115
      Width           =   1335
   End
   Begin VB.TextBox txtPuntoFin 
      Height          =   285
      Left            =   1800
      MaxLength       =   10
      TabIndex        =   2
      Top             =   840
      Width           =   1065
   End
   Begin VB.TextBox txtPuntoIni 
      Height          =   285
      Left            =   1800
      MaxLength       =   10
      TabIndex        =   1
      Top             =   510
      Width           =   1065
   End
   Begin VB.TextBox txtCB 
      Height          =   285
      Left            =   1800
      MaxLength       =   5
      TabIndex        =   0
      Top             =   195
      Width           =   1065
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   1
      Left            =   5535
      TabIndex        =   4
      Top             =   1185
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   0
      Left            =   1800
      TabIndex        =   3
      Top             =   1185
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBuscar 
      Height          =   750
      Left            =   8550
      TabIndex        =   10
      Top             =   105
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdSiguientes 
      Height          =   750
      Left            =   8550
      TabIndex        =   11
      Top             =   885
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Siguiente"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdSalir 
      Height          =   750
      Index           =   3
      Left            =   8550
      TabIndex        =   14
      Top             =   3255
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdExcel 
      Height          =   750
      Index           =   1
      Left            =   8550
      TabIndex        =   12
      Top             =   1680
      WhatsThisHelpID =   2068
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Excel"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdLimpiar 
      Height          =   750
      Index           =   2
      Left            =   8550
      TabIndex        =   13
      Top             =   2460
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2745
      Left            =   120
      TabIndex        =   17
      Top             =   2730
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   4842
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox mskHora 
      Height          =   285
      Index           =   1
      Left            =   5535
      TabIndex        =   6
      Top             =   1515
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskHora 
      Height          =   285
      Index           =   0
      Left            =   1800
      TabIndex        =   5
      Top             =   1500
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MskeditLib.MaskInBox txtMonto 
      Height          =   255
      Index           =   0
      Left            =   1785
      TabIndex        =   7
      Top             =   1815
      Width           =   1335
      _Version        =   262144
      _ExtentX        =   2355
      _ExtentY        =   450
      _StockProps     =   253
      Text            =   "0.00"
      Appearance      =   1
      Decimals        =   2
      Separator       =   -1  'True
      MaskType        =   0
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   0   'False
      DateString      =   ""
      FormattedText   =   ""
      Mask            =   ""
      HelpLine        =   ""
      ClipText        =   "0.00"
      ClipMode        =   0
      StringIndex     =   0
      DateType        =   0
      DateSybase      =   "12/16/13"
      AutoDecimal     =   0   'False
      MinReal         =   -1.1e38
      MaxReal         =   3.4e38
      Units           =   0
      Errores         =   0
   End
   Begin MskeditLib.MaskInBox txtMonto 
      Height          =   255
      Index           =   1
      Left            =   5535
      TabIndex        =   8
      Top             =   1830
      Width           =   1335
      _Version        =   262144
      _ExtentX        =   2355
      _ExtentY        =   450
      _StockProps     =   253
      Text            =   "0.00"
      Appearance      =   1
      Decimals        =   2
      Separator       =   -1  'True
      MaskType        =   0
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   0   'False
      DateString      =   ""
      FormattedText   =   ""
      Mask            =   ""
      HelpLine        =   ""
      ClipText        =   "0.00"
      ClipMode        =   0
      StringIndex     =   0
      DateType        =   0
      DateSybase      =   "12/16/13"
      AutoDecimal     =   0   'False
      MinReal         =   -1.1e38
      MaxReal         =   3.4e38
      Units           =   0
      Errores         =   0
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8520
      X2              =   8520
      Y1              =   -30
      Y2              =   5640
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Hasta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   4335
      TabIndex        =   30
      Top             =   1200
      Width           =   1155
   End
   Begin VB.Label lblTipoTran 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   3165
      TabIndex        =   29
      Top             =   2130
      UseMnemonic     =   0   'False
      Width           =   5235
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Transacción"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   225
      TabIndex        =   28
      Top             =   2190
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto Hasta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   4320
      TabIndex        =   27
      Top             =   1755
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Desde:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   225
      TabIndex        =   26
      Top             =   1260
      Width           =   1200
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Punto Desde:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   240
      TabIndex        =   25
      Top             =   585
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Hora Desde:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   240
      TabIndex        =   24
      Top             =   1575
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Hora Hasta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   4320
      TabIndex        =   23
      Top             =   1485
      Width           =   1035
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Punto Hasta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   240
      TabIndex        =   22
      Top             =   900
      Width           =   1125
   End
   Begin VB.Label lblPuntoFin 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2940
      TabIndex        =   21
      Top             =   795
      UseMnemonic     =   0   'False
      Width           =   5475
   End
   Begin VB.Label lblPuntoIni 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2940
      TabIndex        =   20
      Top             =   495
      UseMnemonic     =   0   'False
      Width           =   5475
   End
   Begin VB.Label lblCuentaCB 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   7800
      TabIndex        =   19
      Top             =   1560
      UseMnemonic     =   0   'False
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   3
      X1              =   0
      X2              =   8490
      Y1              =   2520
      Y2              =   2520
   End
   Begin VB.Label lblCB 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2940
      TabIndex        =   18
      Top             =   195
      UseMnemonic     =   0   'False
      Width           =   5475
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto Desde:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   225
      TabIndex        =   16
      Top             =   1860
      Width           =   1200
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Red Posicionada:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   225
      TabIndex        =   15
      Top             =   240
      Width           =   1515
   End
End
Attribute VB_Name = "FGesCtaCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10

Dim VLValida As Boolean

Private Sub cmdBuscar_Click()
    PLBuscar
End Sub

Private Sub cmdExcel_Click(Index As Integer)
    PLExcel
End Sub

Private Sub cmdLimpiar_Click(Index As Integer)
    PLLimpiar
End Sub

Private Sub cmdSalir_Click(Index As Integer)
    Unload Me
End Sub

Private Sub cmdSiguientes_Click()
    PLSiguiente
End Sub

Private Sub Form_Load()

    PMLoadResStrings Me
    PMLoadResIcons Me
    
    Me.Height = 6105
    Me.Width = 9615
    Me.Top = 15
    Me.Left = 15
    PLLimpiar
End Sub

Private Sub mskFecha_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'14/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Index = 0 Then
        FPrincipal!pnlHelpLine.Caption = " Fecha Inicial de Consulta (" + VGFormatoFecha$ + ")"
    Else
        FPrincipal!pnlHelpLine.Caption = " Fecha Final de Consulta (" + VGFormatoFecha$ + ")"
    End If
    MskFecha(Index).SelStart = 0
    MskFecha(Index).SelLength = Len(MskFecha(Index).Text)
End Sub

Private Sub MskFecha_LostFocus(Index As Integer)
On Error Resume Next
    Select Case Index%
    Case 0, 1
        If MskFecha(Index%).ClipText <> "" Then
            VTValido% = FMVerFormato((MskFecha(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                MskFecha(Index%).Mask = ""
                MskFecha(Index%).Text = ""
                MskFecha(Index%).Mask = FMMascaraFecha(VGFormatoFecha$)
                MskFecha(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i% = 0 To 1
                MskFecha(i%).Mask = ""
                MskFecha(i%).Text = ""
                MskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
            Next i%
        End If
        
        If MskFecha(0).ClipText <> "" And MskFecha(1).ClipText <> "" Then
            VTDias& = FMDateDiff("d", (MskFecha(0).FormattedText), (MskFecha(1).FormattedText), VGFormatoFecha$)
            If VTDias& < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i% = 0 To 1
                    MskFecha(i%).Mask = ""
                    MskFecha(i%).Text = ""
                    MskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
                Next i%
                Exit Sub
            End If
        End If
    End Select
End Sub

Private Sub mskHora_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'14/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Index = 0 Then
        FPrincipal!pnlHelpLine.Caption = " Hora Inicial de Consulta (HH:MM:SS)"
    Else
        FPrincipal!pnlHelpLine.Caption = " Hora Final de Consulta (HH:MM:SS)"
    End If
    mskHora(Index).SelStart = 0
    mskHora(Index).SelLength = Len(mskHora(Index).Text)
End Sub

Private Sub mskHora_LostFocus(Index As Integer)
    If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
        If mskHora(0).ClipText > mskHora(1).ClipText Then
            MsgBox "Hora desde mayor a hora hasta", 48, "Mensaje de Error"
            mskHora(1).Mask = ""
            mskHora(1).Text = ""
            mskHora(1).Mask = "##:##:##"
            mskHora(1).SetFocus
            Exit Sub
        End If
    End If
    If mskHora(0).ClipText > "23:59:59" And mskHora(0).ClipText <> "" Then
        MsgBox "El valor para la consulta Hora Desde no puede ser mayor a 23:59:59", 48, "Mensaje de Error"
        mskHora(0).Mask = ""
        mskHora(0).Text = ""
        mskHora(0).Mask = "##:##:##"
        mskHora(0).SetFocus
        Exit Sub
    End If
    If mskHora(1).ClipText > "23:59:59" And mskHora(1).ClipText <> "" Then
        MsgBox "El valor para la consulta Hora Hasta no puede ser mayor a 23:59:59", 48, "Mensaje de Error"
        mskHora(1).Text = ""
        mskHora(1).Mask = ""
        mskHora(1).Mask = "##:##:##"
        mskHora(1).SetFocus
        Exit Sub
    End If
    If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
        If mskHora(0).ClipText = mskHora(1).ClipText Then
            MsgBox "El valor para la Hora Hasta no pueden ser iguales", 48, "Mensaje de Error"
            mskHora(1).Mask = ""
            mskHora(1).Text = ""
            mskHora(1).Mask = "##:##:##"
            mskHora(1).SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub txtCB_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 Luis Moreno         Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Código del Corresponsal [F5] Ayuda"
    txtCB.SelStart = 0
    txtCB.SelLength = Len(txtCB.Text)

End Sub

Private Sub txtCB_KeyDown(Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma FBuscarCliente para traer
'           los datos de un cliente
'Input   :  KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Keycode% = VGTeclaAyuda% Then
        txtCB.Enabled = True
        VLPaso% = True
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1051"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S1"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "2"
        PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT2&, "0"
        PMHelpG "cobis", "sp_clasoser", 3, 1
        PMBuscarG 1, "@t_trn", "1051", SQLINT2&
        PMBuscarG 2, "@i_operacion", "S1", SQLCHAR&
        PMBuscarG 3, "@i_modo", "2", SQLINT1&
        PMSigteG 1, "@i_siguiente", 1, SQLINT4&
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_clasoser", True, "Ayuda Corresponsal") Then
            PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
            PMChequea sqlconn&
            PMProcesG
            grid_valores.Show 1
            If Temporales(1) <> "" Then
                txtCB.Text = Temporales(1)
                lblCB.Caption = Temporales(2)
                VLPaso% = True
                SendKeys "{TAB}"
            Else
                VLPaso% = False
                txtCB_LostFocus
            End If
        End If
    
    End If
End Sub

Private Sub txtCB_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea numerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtCB_LostFocus()
'*********************************************************
'Objetivo:  Cuando el contenido del campo se modifica
'           manualmente, se invoca al sp que trae la des-
'           cripción del código
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    ReDim VTArreglo(3) As String
    If Not VLPaso% Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim(txtCB.Text) <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "703"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
            PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLINT4&, txtCB.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_devolucion_val_recaudo", True, "Ok.. Ayuda Corresponsal") Then
                VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                lblCB.Caption = VTArreglo(1)
                lblCuentaCB.Caption = VTArreglo(3)
            Else
                txtCB.Text = ""
                lblCB.Caption = ""
                lblCuentaCB.Caption = ""
                txtCB.SetFocus
            End If
        End If
    End If
End Sub

Sub PLLimpiar()
'*********************************************************
'Objetivo:  Limpia la pantalla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    txtCB.Text = ""
    lblCB.Caption = ""
    lblCuentaCB.Caption = ""
    txtPuntoIni.Text = ""
    lblPuntoIni.Caption = ""
    txtPuntoFin.Text = ""
    lblPuntoFin.Caption = ""
    MskFecha(0).Mask = ""
    MskFecha(1).Mask = ""
    mskHora(0).Mask = ""
    mskHora(1).Mask = ""
    For i% = 0 To 1
        MskFecha(i%).Mask = ""
        MskFecha(i%).Text = ""
        MskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
    Next i%
    
    For i% = 0 To 1
        mskHora(i%).Mask = ""
        mskHora(i%).Text = ""
        mskHora(i%).Mask = "##:##:##"
    Next i%
    
    txtMonto(0).Text = ""
    txtMonto(1).Text = ""
    PMLimpiaG grdRegistros
    txtTran.Text = ""
    lblTipoTran.Caption = ""
End Sub

Sub PLBuscar()
'*********************************************************
'Objetivo:  Realiza la busqueda de la información
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    Dim HoraIni As String
    Dim HoraFin As String
    
    PLValidarCampos
    If VLValida Then
    
        If mskHora(0).ClipText = "" Then
            HoraIni = "00:00:00"
        End If
        
        If mskHora(1).ClipText = "" Then
            HoraFin = "23:59:59"
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "705"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLINT4&, txtCB.Text
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, lblCuentaCB.Caption
        PMPasoValores sqlconn&, "@i_punto_ini", 0, SQLVARCHAR&, txtPuntoIni.Text
        PMPasoValores sqlconn&, "@i_punto_fin", 0, SQLVARCHAR&, txtPuntoFin.Text
        VTFecha$ = FMConvFecha((MskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFecha$ & " " & HoraIni
        VTFecha$ = FMConvFecha((MskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha$ & " " & HoraFin
        PMPasoValores sqlconn&, "@i_tipo_tran", 0, SQLINT4&, txtTran.Text
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_trn_cb", True, "Ok.. Ayuda Corresponsal") Then
            PMMapeaGrid sqlconn&, grdRegistros, False
            PMChequea sqlconn&
            If Val(grdRegistros.Tag) = 20 Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            
            grdRegistros.ColWidth(13) = 1
    
        Else
            PMChequea sqlconn&
            PMLimpiaG grdRegistros
        End If
        
    End If
End Sub

Sub PLSiguiente()
'*********************************************************
'Objetivo:  Realiza la busqueda de la información
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    Dim HoraIni As String
    Dim HoraFin As String
    
    PLValidarCampos
    If VLValida Then
    
        If mskHora(0).ClipText = "" Then
            HoraIni = "00:00:00"
        End If
        
        If mskHora(1).ClipText = "" Then
            HoraFin = "23:59:59"
        End If
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "705"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLINT2&, txtCB.Text
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, lblCuentaCB.Caption
        PMPasoValores sqlconn&, "@i_punto_ini", 0, SQLVARCHAR&, txtPuntoIni.Text
        PMPasoValores sqlconn&, "@i_punto_fin", 0, SQLVARCHAR&, txtPuntoFin.Text
        VTFecha$ = FMConvFecha((MskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFecha$ & " " & HoraIni
        VTFecha$ = FMConvFecha((MskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha$ & " " & HoraFin
        PMPasoValores sqlconn&, "@i_tipo_tran", 0, SQLINT4&, txtTran.Text
        
        grdRegistros.Col = grdRegistros.Cols - 1
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4&, grdRegistros.Text
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_trn_cb", True, "Ok.. Ayuda Corresponsal") Then

            PMMapeaGrid sqlconn&, grdRegistros, True
            PMChequea sqlconn&
            If Val(grdRegistros.Tag) = 20 Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
        Else
            PMChequea sqlconn&
        End If
        
    End If
End Sub

Sub PLValidarCampos()
'*********************************************************
'Objetivo:  Valida que los campos para consulta tengan datos
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    VLValida = False
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtCB) = "" Then
        MsgBox "Ingrese Red Posicionada", vbInformation, "Error Validación Campos"
        txtCB.SetFocus
        Exit Sub
    End If

'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(lblCuentaCB.Caption) = "" Then
        MsgBox "Cuenta del Corresponsal no encontrada", vbInformation, "Error Validación Campos"
        Exit Sub
    End If
    
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtPuntoIni) = "" Then
        MsgBox "Ingrese Punto Desde", vbInformation, "Error Validación Campos"
        txtPuntoIni.SetFocus
        Exit Sub
    End If

'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtPuntoFin) = "" Then
        MsgBox "Ingrese Punto Hasta", vbInformation, "Error Validación Campos"
        txtPuntoFin.SetFocus
        Exit Sub
    End If

    If MskFecha(0).ClipText = "" Then
        MsgBox "Ingrese fecha desde para la consulta", vbInformation, "Error Validación Campos"
        MskFecha(0).SetFocus
        Exit Sub
    End If
    
    If MskFecha(1).ClipText = "" Then
        MsgBox "Ingrese fecha hasta para la consulta", vbInformation, "Error Validación Campos"
        MskFecha(1).SetFocus
        Exit Sub
    End If
    
    VTDias& = FMDateDiff("d", (MskFecha(0).FormattedText), (MskFecha(1).FormattedText), VGFormatoFecha$)
    If VTDias& < 0 Then
        MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
        For i% = 0 To 1
            MskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
        Next i%
        Exit Sub
    End If
    
    If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
        If mskHora(0).ClipText > mskHora(1).ClipText Then
            MsgBox "Hora desde mayor a hora hasta", 48, "Mensaje de Error"
            MskFecha(Index%).SetFocus
            Exit Sub
        End If
    End If
        
    VLValida = True
End Sub

Private Sub PLExcel()
'*********************************************************
'Objetivo:  Valida que haya información en la grilla para
'           la generación de la información en excel
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    grdRegistros.Row = 1
    grdRegistros.Col = 1
    If grdRegistros.Text <> "" Then
        GeneraDatos_Excel
    Else
        MsgBox "No hay datos en la Grilla", vbCritical, "ERROR"
        'mtxtProducto.SetFocus
    End If
End Sub

Sub GeneraDatos_Excel()
'*********************************************************
'Objetivo:  Genera archivo en excel a partir de la información
'           de la grilla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************

    On Local Error GoTo ErrGeneraDatos_Excel
    Dim XlsApl As Excel.Application
    Dim xlsLibro As Excel.Workbook
    Dim xlhoja As Excel.Worksheet
    Dim nlTimer As Long
    
    nlTimer = Timer
    
    Set XlsApl = New Excel.Application
    XlsApl.Caption = "INFORME DE GESTIÓN DE CUENTAS DE CORRESPONSALÍA"
    XlsApl.WindowState = xlMinimized
    
    
    With XlsApl
        .Workbooks.Add
        Set xlsLibro = .ActiveWorkbook
        Set xlhoja = xlsLibro.Worksheets.Add
        xlhoja.Name = "GESTION_CTAS_CORR"
        
        With xlsLibro.Worksheets("GESTION_CTAS_CORR")
            XlsApl.Columns("E:F").Select
            XlsApl.Rows("5:10").Select
            XlsApl.Selection.NumberFormat = "@"
            
            FPrincipal.pnlHelpLine.Caption = " Exportando Archivo [" + svArchivo + "] ..."
            Fil = 1
            Col = 4
            .Cells(Fil, Col) = "INFORME DE GESTIÓN DE CUENTAS DE CORRESPONSALÍA"
            
            Fil = 2
            Col = 4
            .Cells(Fil, Col) = "REDES POSICIONADAS"
            
            Fil = 4
            Col = 4
            .Cells(Fil, Col) = "Código de Red"
            Col = 5
            .Cells(Fil, Col) = txtCB.Text
            
            Fil = 5
            Col = 4
            .Cells(Fil, Col) = "Tipo de Transacción"
            Col = 5
            .Cells(Fil, Col) = txtTran.Text

            
            Fil = 6
            Col = 5
            .Cells(Fil, Col) = "Desde"
            Col = 6
            .Cells(Fil, Col) = "Hasta"
            
           
            Fil = 7
            Col = 4
            .Cells(Fil, Col) = "Código del Punto"
            Col = 5
            .Cells(Fil, Col) = txtPuntoIni.Text
            Col = 6
            .Cells(Fil, Col) = txtPuntoFin.Text
            
            Fil = 8
            Col = 4
            .Cells(Fil, Col) = "Fecha (DD/MM/AAAA)"
            Col = 5
            .Cells(Fil, Col) = MskFecha(0).Text
            Col = 6
            .Cells(Fil, Col) = MskFecha(1).Text
            
            Fil = 9
            Col = 4
            .Cells(Fil, Col) = "Hora (HH:MM:SS)"
            Col = 5
            .Cells(Fil, Col) = mskHora(0).Text
            Col = 6
            .Cells(Fil, Col) = mskHora(1).Text
            
            Fil = 10
            Col = 4
            .Cells(Fil, Col) = "Monto en Pesos"
            Col = 5
            .Cells(Fil, Col) = txtMonto(0).Text
            Col = 6
            .Cells(Fil, Col) = txtMonto(1).Text
            
                        
            Col = 1
            For fila = 0 To grdRegistros.Rows - 1
            Fil = Fil + 1
                FPrincipal.pnlHelpLine.Caption = " Exportando fila [" + CStr(fila) + "] de " + CStr(grdRegistros.Rows - 1) + " ..."
                grdRegistros.Row = fila
                Col = 0
                For columna = 1 To grdRegistros.Cols - 2
                Col = Col + 1
                    grdRegistros.Col = columna
                    valor$ = grdRegistros.Text
                    If Col = 1 Then
                       If FMConvFecha(valor$, VGFecha_Pref$, VGFormatoFecha$) <> "" Then
                           .Cells(Fil + 1, Col) = "'" + grdRegistros.Text
                       Else
                           .Cells(Fil + 1, Col) = grdRegistros.Text
                       End If
                    Else
                       .Cells(Fil + 1, Col) = grdRegistros.Text
                    End If
                Next
            Next
       End With
    End With
    XlsApl.Visible = True
    XlsApl.WindowState = xlMaximized
    XlsApl.Selection.Borders(xlInsideVertical).LineStyle = xlNone
    XlsApl.Cells.Select
    XlsApl.Range("E1").Activate
    XlsApl.Cells.EntireColumn.AutoFit
     
    Exit Sub
ErrGeneraDatos_Excel:
    MsgBox Err.Number & " - " & Err.Description, vbInformation
    Exit Sub 'Resume Next
End Sub

Private Sub txtMonto_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'14/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Index = 0 Then
        FPrincipal!pnlHelpLine.Caption = " Monto Inicial de Consulta"
    Else
        FPrincipal!pnlHelpLine.Caption = " Monto Final de Consulta"
    End If
End Sub

Private Sub txtMonto_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea numerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If

End Sub

Private Sub txtPuntoFin_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 Luis Moreno         Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Punto Final [F5] Ayuda"
    txtPuntoFin.SelStart = 0
    txtPuntoFin.SelLength = Len(txtPuntoFin.Text)
    
    VLPaso% = True
End Sub

Private Sub txtPuntoFin_KeyDown(Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma FBuscarCliente para traer
'           los datos de un cliente
'Input   :  KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Keycode% = VGTeclaAyuda% Then
        txtCB.Enabled = True
        VLPaso% = True
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "704"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S1"
        PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLINT4&, txtCB.Text
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, "0"
        PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, txtPuntoIni.Text

        PMHelpG "cob_remesas", "sp_punto_red_cb", 4, 1
        PMBuscarG 1, "@t_trn", "704", SQLINT2&
        PMBuscarG 2, "@i_operacion", "S1", SQLCHAR&
        PMBuscarG 3, "@i_modo", "0", SQLINT2&
        PMBuscarG 4, "@i_codigo_cb", txtCB.Text, SQLINT4&
        
        PMSigteG 1, "@i_codigo_punto", 1, SQLVARCHAR&
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "Ayuda Corresponsal") Then
            PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
            PMChequea sqlconn&
            PMProcesG
            grid_valores.Show 1
            If Temporales(1) <> "" Then
                txtPuntoFin.Text = Temporales(2)
                lblPuntoFin.Caption = Temporales(3)
                VLPaso% = True
                SendKeys "{TAB}"
            Else
                VLPaso% = False
                txtCB_LostFocus
            End If
        End If
    End If

End Sub

Private Sub txtPuntoFin_LostFocus()
'*********************************************************
'Objetivo:  Cuando el contenido del campo se modifica
'           manualmente, se invoca al sp que trae la des-
'           cripción del código
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    ReDim VTArreglo(3) As String
    If Not VLPaso% Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim(txtPuntoFin.Text) <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "704"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLINT4&, txtCB.Text
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, "1"
            PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, txtPuntoFin.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "Ok.. Ayuda Corresponsal") Then
                VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                txtPuntoFin.Text = VTArreglo(1)
                lblPuntoFin.Caption = VTArreglo(2)
            Else
                VLPaso% = True
                txtPuntoFin.Text = ""
                lblPuntoFin.Caption = ""
            End If
        End If
    End If

End Sub

Private Sub txtPuntoIni_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 Luis Moreno         Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Punto Inicial [F5] Ayuda"
    txtPuntoIni.SelStart = 0
    txtPuntoIni.SelLength = Len(txtPuntoIni.Text)

    VLPaso% = True
End Sub

Private Sub txtPuntoIni_KeyDown(Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma FBuscarCliente para traer
'           los datos de un cliente
'Input   :  KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Keycode% = VGTeclaAyuda% Then
        txtCB.Enabled = True
        VLPaso% = True
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "704"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S1"
        PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLINT4&, txtCB.Text
        PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, ""
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMHelpG "cob_remesas", "sp_punto_red_cb", 4, 1
        PMBuscarG 1, "@t_trn", "704", SQLINT2&
        PMBuscarG 2, "@i_operacion", "S1", SQLCHAR&
        PMBuscarG 3, "@i_modo", "0", SQLINT1&
        PMBuscarG 4, "@i_codigo_cb", txtCB.Text, SQLINT4&
        
        PMSigteG 1, "@i_codigo_punto", 1, SQLVARCHAR&
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "Ayuda Corresponsal") Then
            PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
            PMChequea sqlconn&
            PMProcesG
            grid_valores.Show 1
            If Temporales(1) <> "" Then
                txtPuntoIni.Text = Temporales(2)
                lblPuntoIni.Caption = Temporales(3)
                VLPaso% = True
                SendKeys "{TAB}"
            Else
                VLPaso% = False
                txtCB_LostFocus
            End If
        End If
    End If

End Sub

Private Sub txtPuntoIni_LostFocus()
'*********************************************************
'Objetivo:  Cuando el contenido del campo se modifica
'           manualmente, se invoca al sp que trae la des-
'           cripción del código
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    ReDim VTArreglo(3) As String
    If Not VLPaso% Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim(txtPuntoIni.Text) <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "704"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLINT2&, txtCB.Text
            PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, txtPuntoIni.Text
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, 1
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "Ok.. Ayuda Corresponsal") Then
                VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                txtPuntoIni.Text = VTArreglo(1)
                lblPuntoIni.Caption = VTArreglo(2)
            Else
                VLPaso% = True
                txtPuntoIni.Text = ""
                lblPuntoIni.Caption = ""
            End If
        End If
    End If
End Sub

Private Sub txtTran_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 Luis Moreno         Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Código de la Transacción [F5] Ayuda"
    txtTran.SelStart = 0
    txtTran.SelLength = Len(txtTran.Text)
End Sub

Private Sub txtTran_KeyDown(Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma FBuscarCliente para traer
'           los datos de un cliente
'Input   :  KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'12/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    If Keycode% = VGTeclaAyuda% Then

        VLPaso% = True
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ws_tran_canales"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la transacción") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtTran.Text = VGACatalogo.Codigo$
            lblTipoTran.Caption = VGACatalogo.Descripcion$
        Else
            txtTran.Text = ""
            txtTran.SetFocus
            lblTipoTran.Caption = ""
        End If
    End If
End Sub

Private Sub txtTran_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtTran_LostFocus()
    'If VLPaso% = False Then
        If txtTran.Text <> "" Then
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ws_tran_canales"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtTran.Text)
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtTran.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblTipoTran
                 PMChequea sqlconn&
            Else
                VLPaso% = True
                txtTran.Text = ""
                lblTipoTran.Caption = ""
            End If
        Else
            lblTipoTran.Caption = ""
        End If
    'End If
End Sub

