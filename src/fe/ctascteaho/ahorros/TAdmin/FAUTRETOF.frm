VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FAUTRETOF 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Autorización  Retiros en Oficina"
   ClientHeight    =   5205
   ClientLeft      =   2160
   ClientTop       =   2715
   ClientWidth     =   9270
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5205
   ScaleWidth      =   9270
   Begin VB.Frame fraTasas 
      Caption         =   "Criterios de Búsqueda"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   1965
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8295
      Begin VB.Frame Frame1 
         Caption         =   "Oficina Radicadora"
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
         Height          =   555
         Index           =   1
         Left            =   4080
         TabIndex        =   17
         Top             =   120
         Width           =   2415
         Begin Threed.SSOption optPago 
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   18
            Top             =   240
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Si"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optPago 
            Height          =   255
            Index           =   3
            Left            =   960
            TabIndex        =   19
            Top             =   240
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "No"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin MhinrelLib.MhRealInput txtValor 
         Height          =   285
         Left            =   4080
         TabIndex        =   4
         Top             =   1300
         Width           =   2385
         _Version        =   458753
         _ExtentX        =   4207
         _ExtentY        =   503
         _StockProps     =   205
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         FillColor       =   16777215
         MaxReal         =   0
         MinReal         =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin VB.Frame Frame1 
         Caption         =   "Forma Pago"
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
         Height          =   670
         Index           =   0
         Left            =   120
         TabIndex        =   12
         Top             =   1080
         Width           =   3015
         Begin Threed.SSOption optPago 
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   13
            Top             =   300
            Width           =   1455
            _Version        =   65536
            _ExtentX        =   2566
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Efectivo"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optPago 
            Height          =   255
            Index           =   1
            Left            =   1680
            TabIndex        =   14
            Top             =   300
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Cheque"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   255
         Left            =   1560
         TabIndex        =   9
         Top             =   360
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   450
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin VB.Label lblNombre 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   1560
         TabIndex        =   15
         Top             =   720
         Width           =   6615
      End
      Begin VB.Label lblEtiqueta 
         Caption         =   "Valor:"
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
         Height          =   255
         Index           =   2
         Left            =   3480
         TabIndex        =   11
         Top             =   1320
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Caption         =   "Nombre Cuenta:"
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
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   720
         Width           =   1575
      End
      Begin VB.Label lblEtiqueta 
         Caption         =   "No. Cuenta:"
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
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   360
         Width           =   1815
      End
   End
   Begin MSGrid.Grid grdAutoriza 
      Height          =   2895
      Left            =   0
      TabIndex        =   1
      Top             =   2280
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   5106
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
      Left            =   8385
      TabIndex        =   2
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FAUTRETOF.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   1
      Left            =   8385
      TabIndex        =   3
      Top             =   885
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FAUTRETOF.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   4
      Left            =   8385
      TabIndex        =   5
      Top             =   4320
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FAUTRETOF.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   2
      Left            =   8385
      TabIndex        =   6
      Top             =   3450
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FAUTRETOF.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   3
      Left            =   8385
      TabIndex        =   16
      Tag             =   "2536"
      Top             =   1750
      WhatsThisHelpID =   2023
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1508
      _StockProps     =   78
      Caption         =   "Bl&oquear"
      ForeColor       =   8388608
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
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Datos:"
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
      Left            =   0
      TabIndex        =   10
      Top             =   2040
      Width           =   570
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8355
      X2              =   8355
      Y1              =   0
      Y2              =   5295
   End
End
Attribute VB_Name = "FAUTRETOF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FAUTRETOF.FRM
'   Producto:       CUENTAS DE AHORROS
'   Diseñado por:   Andres Diab
'   Fecha de Documentación: 28/06/2011
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

Dim VLSecuencial As String
Dim VLEstado As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
  
    Case 0
        PLBuscar
    Case 1
        PLTransmitir
    Case 3
        PLActualizar
    Case 2
        PLLimpiar
    Case 4
        Unload Me
        
    End Select
End Sub


Private Sub Form_Activate()
        
    mskCuenta.SetFocus
End Sub

Private Sub Form_Load()

    PMLoadResIcons Me
    Me.Top = 15
    Me.Left = 15
    Me.Height = 5770
    Me.Width = 9420
    
    mskCuenta.Mask = VGMascaraCtaAho$
    txtValor.Text = "0.00"
    PLBuscar
End Sub
Private Sub grdAutoriza_Click()
    PMLineaG grdAutoriza
End Sub

Private Sub grdAutoriza_DblClick()
    PLEscoger
End Sub

Private Sub PLBuscar()
    
    If mskCuenta.ClipText = "" Then
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    Else
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
    End If
        
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4133"
     
    If txtValor.Text <> "" Then
       PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY&, txtValor.Text
    Else
       PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY&, "0"
    End If
     
    If optPago(1).Value = True Then
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "C"
    Else
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "E"
    End If
     
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
        PMMapeaGrid sqlconn&, grdAutoriza, False
        PMChequea sqlconn&
    End If
        
End Sub

Private Sub PLEscoger()
Dim VTFila As Integer

grdAutoriza.col = 1
VTFila = grdAutoriza.Row
grdAutoriza.Row = 1
If grdAutoriza.Rows <= 2 And grdAutoriza.Text = "" Then
    Exit Sub
End If
grdAutoriza.Row = VTFila%

mskCuenta.Mask = VGMascaraCtaAho$
mskCuenta.Text = FMMascara(grdAutoriza.Text, VGMascaraCtaAho$)
grdAutoriza.col = 2
lblNombre.Caption = grdAutoriza.Text
grdAutoriza.col = 3
If grdAutoriza.Text = "E" Then
    optPago(0).Value = True
    optPago(1).Value = False
Else
    optPago(1).Value = True
    optPago(0).Value = False
End If
grdAutoriza.col = 4
txtValor.Text = grdAutoriza.Text

grdAutoriza.col = 5
VLEstado = grdAutoriza.Text

grdAutoriza.col = grdAutoriza.Cols - 2
If grdAutoriza.Text = "S" Then
    optPago(2).Value = True
    optPago(3).Value = False
Else
    optPago(2).Value = False
    optPago(3).Value = True
End If

grdAutoriza.col = grdAutoriza.Cols - 1
VLSecuencial = grdAutoriza.Text

cmdBoton(1).Enabled = False
cmdBoton(3).Enabled = True

End Sub

Private Sub PLTransmitir()

If mskCuenta.ClipText = "" Then
    MsgBox "Número de la cuenta es obligatorio", 16, "Atención"
    Exit Sub
End If
If txtValor.Text = "" Then
    MsgBox "Valor a autorizar es obligatorio", 16, "Atención"
    Exit Sub
End If

    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "I"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4131"
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY&, txtValor.Text
    If optPago(1).Value = True Then
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "C"
    Else
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "E"
    End If
    
    If optPago(2).Value = True Then
       PMPasoValores sqlconn&, "@i_ofi_radica", 0, SQLCHAR&, "S"
    Else
       PMPasoValores sqlconn&, "@i_ofi_radica", 0, SQLCHAR&, "N"
    End If
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
        PMMapeaGrid sqlconn&, grdAutoriza, False
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
    End If
End Sub

Private Sub PLActualizar()

If mskCuenta.ClipText = "" Then
    MsgBox "Número de la cuenta es obligatorio", 16, "Atención"
    Exit Sub
End If
If txtValor.Text = "" Or txtValor.Text = "0.00" Then
    MsgBox "Valor de la autorización es obligatorio", 16, "Atención"
    Exit Sub
End If
If VLEstado = "B" Then
    MsgBox "Autorización se encuentra bloqueada", 16, "Atención"
    Exit Sub
End If

    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "U"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4132"
    PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4&, VLSecuencial
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY&, txtValor.Text
    If optPago(1).Value = True Then
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "C"
    Else
       PMPasoValores sqlconn&, "@i_forma_pago", 0, SQLCHAR&, "E"
    End If
     
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
        PMMapeaGrid sqlconn&, grdAutoriza, False
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
        cmdBoton(1).Enabled = True
        cmdBoton(3).Enabled = False
    End If
End Sub

Private Sub PLLimpiar()

mskCuenta.Mask = VGMascaraCtaAho$
mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
txtValor.Text = "0.00"
lblNombre.Caption = ""
PMLimpiaG grdAutoriza
cmdBoton(1).Enabled = True
cmdBoton(3).Enabled = False
PLBuscar
End Sub

Private Sub mskCuenta_LostFocus()
Dim VTNombre As String

If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4133"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "C"
             PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_aut_retiro_oficina", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                PMMapeaVariable sqlconn&, VTNombre
                PMChequea sqlconn&
                lblNombre.Caption = VTNombre$
                cmdBoton(1).Enabled = True
                cmdBoton(3).Enabled = False
            Else
                PLLimpiar
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            PLLimpiar
            Exit Sub
        End If
    End If

End Sub

Private Sub txtValor_GotFocus()
    txtValor.SelStart = 0
    txtValor.SelLength = Len(txtValor.Text)
    'txtValor.Text = Format(txtValor.Text, "#,###.00")
End Sub

Private Sub txtValor_KeyPress(KeyAscii As Integer)
    If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
         KeyAscii = 0
     End If
     KeyAscii = FMValidarNumero((txtValor.Text), 16, KeyAscii, "105")
    'KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Function FMValidarNumero(parValor As String, parLongitud As Integer, parcaracter As Integer, parNemonico As String) As Integer

  Dim VTDecimal As Integer
  Dim VTSeparadorDecimal As String
  Dim CGTeclaMenos As String
  

  VTSeparadorDecimal$ = "."

  VTDecimal% = 2
  If parcaracter% = CGTeclaMenos Then
    'CHM 08-nov-99
    FMValidarNumero% = 0
    Exit Function
  End If

  If (VTDecimal% > 0) Then
      If (InStr(1, parValor, VTSeparadorDecimal$)) >= (parLongitud + (VTDecimal) + 1) Then
        FMValidarNumero% = 0
      Else
        FMValidarNumero% = parcaracter%
      End If
  Else
    If Len(parValor) >= parLongitud Then
      FMValidarNumero% = 0
    Else
      FMValidarNumero% = parcaracter%
    End If
  End If

End Function

