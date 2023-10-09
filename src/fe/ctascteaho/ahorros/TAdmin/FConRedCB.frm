VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FConRedCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consolidados de Redes Posicionadas"
   ClientHeight    =   4005
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9495
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   4005
   ScaleWidth      =   9495
   Begin VB.OptionButton optEstado 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Reversadas"
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
      Height          =   330
      Index           =   2
      Left            =   5205
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1050
      Value           =   -1  'True
      Width           =   1545
   End
   Begin VB.OptionButton optEstado 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Declinadas"
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
      Height          =   330
      Index           =   1
      Left            =   3555
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1050
      Width           =   1305
   End
   Begin VB.OptionButton optEstado 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Exitosas"
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
      Height          =   330
      Index           =   0
      Left            =   2070
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   1050
      Width           =   1155
   End
   Begin VB.TextBox txtCB 
      Height          =   285
      Left            =   1755
      MaxLength       =   5
      TabIndex        =   1
      Top             =   210
      Width           =   735
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   1
      Left            =   5520
      TabIndex        =   3
      Top             =   630
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   0
      Left            =   1755
      TabIndex        =   2
      Top             =   630
      Width           =   1305
      _ExtentX        =   2302
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBuscar 
      Height          =   750
      Left            =   8565
      TabIndex        =   7
      Top             =   75
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
      Left            =   8565
      TabIndex        =   8
      Top             =   855
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
      Left            =   8565
      TabIndex        =   11
      Top             =   3195
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
      Left            =   8565
      TabIndex        =   9
      Top             =   1635
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
      Left            =   8565
      TabIndex        =   10
      Top             =   2415
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
      Height          =   2265
      Left            =   120
      TabIndex        =   13
      Top             =   1545
      Width           =   8175
      _Version        =   65536
      _ExtentX        =   14420
      _ExtentY        =   3995
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
      Left            =   240
      TabIndex        =   16
      Top             =   675
      Width           =   1200
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
      Left            =   7755
      TabIndex        =   15
      Top             =   690
      UseMnemonic     =   0   'False
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   3
      X1              =   45
      X2              =   8475
      Y1              =   1395
      Y2              =   1395
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8460
      X2              =   8460
      Y1              =   -30
      Y2              =   3945
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
      Left            =   2580
      TabIndex        =   14
      Top             =   210
      UseMnemonic     =   0   'False
      Width           =   5595
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
      Left            =   4080
      TabIndex        =   12
      Top             =   675
      Width           =   1155
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
      TabIndex        =   0
      Top             =   255
      Width           =   1515
   End
End
Attribute VB_Name = "FConRedCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10

Option Explicit

Dim VLValida As Boolean
Dim i As Integer
Dim VLPaso As Integer
Dim svArchivo As String
Dim Fil As Integer
Dim col As Integer
Dim VLEstado As String
Dim fila As Integer
Dim columna As Integer
Dim valor As String







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
    
    Me.Height = 4600
    Me.Width = 9615
    Me.Top = 15
    Me.Left = 15
    PLLimpiar

End Sub

Private Sub grdRegistros_Click()
    PMLineaG grdRegistros
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
    mskFecha(Index).SelStart = 0
    mskFecha(Index).SelLength = Len(mskFecha(Index).Text)
End Sub

Private Sub MskFecha_LostFocus(Index As Integer)
Dim VTValido As Integer
Dim VTDias As Long

On Error Resume Next
    Select Case Index
    Case 0, 1
        If mskFecha(Index%).ClipText <> "" Then
            VTValido = FMVerFormato((mskFecha(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskFecha(Index%).Mask = ""
                mskFecha(Index%).Text = ""
                mskFecha(Index%).Mask = FMMascaraFecha(VGFecha_Pref)
                mskFecha(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i% = 0 To 1
                mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
            Next i%
        End If
        
        If mskFecha(0).ClipText <> "" And mskFecha(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskFecha(0).FormattedText), (mskFecha(1).FormattedText), VGFormatoFecha$)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i% = 0 To 1
                    mskFecha(1).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskFecha(1).Mask = ""
                    mskFecha(1).Text = ""
                    mskFecha(1).Mask = FMMascaraFecha(VGFecha_Pref)
                    mskFecha(1).SetFocus
                Next i%
                Exit Sub
            End If
            If VTDias& > 30 Then
                MsgBox "El intervalo en días entre los campos Fecha Desde y Fecha Hasta no debe superar 30 días", 48, "Mensaje de Error"
                Exit Sub
            End If
        End If
    End Select

End Sub

Private Sub optEstado_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'14/Mar/2014 Luis Moreno         Emisión Inicial
'*********************************************************
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Transacciones Exitosas"
    Case 1
        FPrincipal!pnlHelpLine.Caption = "Transacciones Declinadas"
    Case 2
        FPrincipal!pnlHelpLine.Caption = "Todas las Transacciones"
    End Select
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
    FPrincipal!pnlHelpLine.Caption = " Código del Corresponsal  [F5] Ayuda"
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
        VLPaso = True
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
                txtCB.SetFocus
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
    Dim VTR As Integer
    
    If Not VLPaso% Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim(txtCB.Text) <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "703"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
            PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLINT4&, txtCB.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_devolucion_val_recaudo", True, "Ok.. Ayuda Corresponsal") Then
                VTR = FMMapeaArreglo(sqlconn&, VTArreglo())
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
    optEstado(0).Value = True
    For i% = 0 To 1
        mskFecha(i%).Mask = ""
        mskFecha(i%).Text = ""
        mskFecha(i%).Mask = FMMascaraFecha(VGFecha_Pref)
    Next i%
    'txtCB.SetFocus
    PMLimpiaG grdRegistros
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
    Dim VTFecha As String
    
    PLValidarCampos
    If VLValida Then
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "706"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLINT2&, txtCB.Text
        VTFecha = FMConvFecha((mskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFecha$
        VTFecha$ = FMConvFecha((mskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha$
        If optEstado(0).Value Then
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "A"
        End If
        If optEstado(1).Value Then
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "X"
        End If
        If optEstado(2).Value Then
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "R"
        End If
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consolida_trn_cb", True, "Ok.. Ayuda Corresponsal") Then
            PMMapeaGrid sqlconn&, grdRegistros, False
            PMChequea sqlconn&
            FormatoGrid
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
    Dim VTFecha As String
    
    PLValidarCampos
    If VLValida Then
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "706"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, 1
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLVARCHAR&, txtCB.Text
        VTFecha = FMConvFecha((mskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFecha$
        VTFecha$ = FMConvFecha((mskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha$
        grdRegistros.col = grdRegistros.Cols - 1
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4&, grdRegistros.Text
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consolida_trn_cb", True, "Ok.. Ayuda Corresponsal") Then

            PMMapeaGrid sqlconn&, grdRegistros, True
            PMChequea sqlconn&
            FormatoGrid
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

Sub FormatoGrid()
    grdRegistros.ColAlignment(1) = 1
    grdRegistros.ColAlignment(2) = 1
    grdRegistros.ColAlignment(3) = 1
    grdRegistros.ColAlignment(4) = 1
    grdRegistros.ColAlignment(5) = 1
    grdRegistros.ColAlignment(6) = 1
    grdRegistros.ColAlignment(7) = 1
    grdRegistros.ColAlignment(8) = 1
    grdRegistros.ColAlignment(9) = 1
    grdRegistros.ColWidth(1) = 885
    grdRegistros.ColWidth(2) = 1350
    grdRegistros.ColWidth(3) = 2000
    grdRegistros.ColWidth(4) = 1500
    grdRegistros.ColWidth(5) = 1500
    grdRegistros.ColWidth(6) = 1500
    grdRegistros.ColWidth(7) = 1500
    grdRegistros.ColWidth(8) = 1500
    grdRegistros.ColWidth(9) = 1500
    grdRegistros.ColWidth(10) = 1500
    grdRegistros.ColWidth(11) = 1
    grdRegistros.ColWidth(12) = 1
            
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
    Dim VTDias As LogEventTypeConstants
    
    
    If txtCB.Text = "" Then
        MsgBox "Ingrese Número de Corresponsal", vbInformation, "Error Validación Campos"
        txtCB.SetFocus
        Exit Sub
    End If
    
    If mskFecha(0).ClipText = "" Then
        MsgBox "Ingrese Fecha Desde para la consulta", vbInformation, "Error Validación Campos"
        mskFecha(0).SetFocus
        Exit Sub
    End If
    
    If mskFecha(1).ClipText = "" Then
        MsgBox "Ingrese Fecha Hasta para la consulta", vbInformation, "Error Validación Campos"
        mskFecha(1).SetFocus
        Exit Sub
    End If
    
    VTDias = FMDateDiff("d", (mskFecha(0).FormattedText), (mskFecha(1).FormattedText), VGFormatoFecha$)
    If VTDias < 0 Then
        MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
        For i% = 0 To 1
            mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
        Next i%
        Exit Sub
    End If
    If VTDias > 30 Then
        MsgBox "El intervalo en días entre los campos Fecha Desde y Fecha Hasta no debe superar 30 días", 48, "Mensaje de Error"
        Exit Sub
    End If
    
    If Not optEstado(0).Value And Not optEstado(1).Value And Not optEstado(2).Value Then
        MsgBox "Debe seleccionar un estado de la transacción para consultar", 48, "Mensaje de Error"
        Exit Sub
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
    grdRegistros.col = 1
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
        xlhoja.Name = "CONSO_REDES_POS"
        
        With xlsLibro.Worksheets("CONSO_REDES_POS")
            
            FPrincipal.pnlHelpLine.Caption = " Exportando Archivo [" + svArchivo + "] ..."
            Fil = 1
            col = 4
            .Cells(Fil, col) = "INFORME CONSOLIDADO DE REDES POSICIONADAS"
                       
            Fil = 3
            col = 4
            .Cells(Fil, col) = "FECHA DESDE"
            col = 5
            .Cells(Fil, col) = "'" + mskFecha(0).Text
            col = 6
            .Cells(Fil, col) = "HASTA"
            col = 7
            .Cells(Fil, col) = "'" + mskFecha(1).Text
            Fil = 4
            col = 4
            .Cells(Fil, col) = "ESTADO"
            
            If optEstado(0).Value = True Then
                VLEstado = "EXITOSAS"
            End If
            
            If optEstado(1).Value = True Then
                VLEstado = "DECLINADAS"
            End If
            
            If optEstado(2).Value = True Then
                VLEstado = "REVERSADAS"
            End If
            
            col = 5
            .Cells(Fil, col) = VLEstado
                                    
            col = 1
            For fila = 0 To grdRegistros.Rows - 1
            Fil = Fil + 1
                FPrincipal.pnlHelpLine.Caption = " Exportando fila [" + CStr(fila) + "] de " + CStr(grdRegistros.Rows - 1) + " ..."
                grdRegistros.Row = fila
                col = 0
                For columna = 1 To grdRegistros.Cols - 3
                col = col + 1
                    grdRegistros.col = columna
                    valor = grdRegistros.Text
                    If col = 1 Then
                       If FMConvFecha(valor$, VGFecha_Pref$, VGFormatoFecha$) <> "" Then
                           .Cells(Fil + 1, col) = "'" + grdRegistros.Text
                       Else
                           .Cells(Fil + 1, col) = grdRegistros.Text
                       End If
                    Else
                       .Cells(Fil + 1, col) = grdRegistros.Text
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

