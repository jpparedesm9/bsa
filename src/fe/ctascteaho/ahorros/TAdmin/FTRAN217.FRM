VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran217 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Bloqueo de Valores la Cuenta de Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   1755
   ClientWidth     =   9510
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1023
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9510
   Tag             =   "3841"
   Begin Threed.SSFrame grdBloqueo 
      Height          =   3468
      Left            =   0
      TabIndex        =   13
      Top             =   1836
      WhatsThisHelpID =   5141
      Width           =   8520
      _Version        =   65536
      _ExtentX        =   15028
      _ExtentY        =   6117
      _StockProps     =   14
      Caption         =   "*Datos del Bloqueo"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   4
         Left            =   1965
         MaxLength       =   3
         TabIndex        =   8
         Top             =   2625
         Width           =   825
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   1965
         MaxLength       =   25
         TabIndex        =   7
         Top             =   2295
         Width           =   3000
      End
      Begin VB.TextBox txtObservacion 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1965
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   6
         Top             =   1875
         Width           =   6400
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   1965
         TabIndex        =   5
         Top             =   1275
         Width           =   6400
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1965
         MaxLength       =   3
         TabIndex        =   4
         Top             =   975
         Width           =   735
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Left            =   1965
         TabIndex        =   3
         Top             =   675
         Width           =   2190
         _ExtentX        =   3863
         _ExtentY        =   503
         _Version        =   393216
         MaxLength       =   15
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   1965
         MaxLength       =   2
         TabIndex        =   2
         Top             =   375
         Width           =   735
      End
      Begin MSMask.MaskEdBox mskCuentacte 
         Height          =   285
         Left            =   1965
         TabIndex        =   9
         Top             =   2970
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   4185
         TabIndex        =   31
         Top             =   2970
         Width           =   4035
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Nro. cuenta corriente:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   30
         TabIndex        =   30
         Top             =   3000
         WhatsThisHelpID =   5091
         Width           =   1965
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Nro. línea sobregiro:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   30
         TabIndex        =   29
         Top             =   2655
         WhatsThisHelpID =   5274
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Número de obligación:"
         ForeColor       =   &H00800000&
         Height          =   192
         Index           =   8
         Left            =   36
         TabIndex        =   28
         Top             =   2328
         WhatsThisHelpID =   5273
         Width           =   1968
      End
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Observaciones: "
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   30
         TabIndex        =   26
         Top             =   1950
         WhatsThisHelpID =   5132
         Width           =   1470
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Solicitado por:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   30
         TabIndex        =   25
         Top             =   1275
         WhatsThisHelpID =   5270
         Width           =   1320
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Plazo en días:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   30
         TabIndex        =   24
         Top             =   975
         WhatsThisHelpID =   5271
         Width           =   1320
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1965
         TabIndex        =   23
         Top             =   1575
         Width           =   6400
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Fecha Vencimiento:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   30
         TabIndex        =   22
         Top             =   1575
         WhatsThisHelpID =   5272
         Width           =   1770
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Valor del bloqueo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   30
         TabIndex        =   15
         Top             =   675
         WhatsThisHelpID =   5140
         Width           =   1635
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Causa de bloqueo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   30
         TabIndex        =   20
         Top             =   375
         WhatsThisHelpID =   5139
         Width           =   1680
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   2710
         TabIndex        =   21
         Top             =   375
         Width           =   5650
      End
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8600
      TabIndex        =   1
      Top             =   990
      WhatsThisHelpID =   2026
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Propiet."
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
      Enabled         =   0   'False
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   816
      Left            =   15
      TabIndex        =   14
      Top             =   912
      Width           =   8520
      _Version        =   65536
      _ExtentX        =   15028
      _ExtentY        =   1439
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8600
      TabIndex        =   10
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8600
      TabIndex        =   11
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8600
      TabIndex        =   12
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8600
      TabIndex        =   27
      Top             =   2280
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
      Enabled         =   0   'False
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   15
      TabIndex        =   19
      Top             =   675
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   15
      TabIndex        =   18
      Top             =   345
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8570
      Y1              =   1770
      Y2              =   1770
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   17
      Top             =   45
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8570
      Y1              =   660
      Y2              =   660
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8570
      X2              =   8570
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   16
      Top             =   345
      UseMnemonic     =   0   'False
      Width           =   6550
   End
End
Attribute VB_Name = "FTran217"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran217.frm
' NOMBRE LOGICO:    FTran217
' PRODUCTO:         Terminal Administrativa
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
' Permite ingresar un bloqueo de valores a una cuenta de ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLPaso As Integer

Private Sub Form_Load()
    FTran217.Left = 0   '15
    FTran217.Top = 0   '15
    FTran217.Width = 9600   '9420
    FTran217.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
    mskCuentacte.Mask = VGMascaraCtaAho$
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
    txtCampo(2).MaxLength = 48
    txtCampo(1).Enabled = False
    txtCampo(3).Enabled = False
    txtCampo(4).Enabled = False
    mskCuentacte.Enabled = False
    lbletiqueta(5).ForeColor = &H808080
    lbletiqueta(8).ForeColor = &H808080
    lbletiqueta(9).ForeColor = &H808080
    lbletiqueta(10).ForeColor = &H808080
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir
        ' Validacion de Mandatoriedades
        ' Numero de Cuenta de Ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        
        ' Causa del Bloqueo
        If Trim$(txtCampo(0).Text) = "" Then
            If VGCodPais$ = "CO" Then
                MsgBox "La causa del bloqueo es mandatoria", 0 + 16, "Mensaje de Error"
            Else
                MsgBox "La causa de la Pignoración es mandatoria", 0 + 16, "Mensaje de Error"
            End If
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ' Valor del bloqueo
        If Val(mskValor.Text) <= 0 Then
            If VGCodPais$ = "CO" Then
                MsgBox "El valor del bloqueo debe ser mayor que cero", 0 + 16, "Mensaje de Error"
            Else
                MsgBox "El valor de la Pignoración debe ser mayor que cero", 0 + 16, "Mensaje de Error"
            End If
            mskValor.SetFocus
            Exit Sub
        End If

        ' Plazo en días
        If Val(txtCampo(1).Text) <= 0 And txtCampo(1).Enabled Then
            MsgBox "El plazo en días debe ser mayor que cero", 0 + 16, "Mensaje de Error"
            If txtCampo(1).Enabled Then txtCampo(1).SetFocus
            Exit Sub
        End If
                
        ' Nombre del Solicitante
        If txtCampo(2).Text = "" Then
            MsgBox "El nombre del solicitante es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        'Observacion
        If txtObservacion.Text = "" Then
            MsgBox "La Observación es mandatoria", 0 + 16, "Mensaje de Error"
            txtObservacion.SetFocus
            Exit Sub
        End If
        ' Verificar valor en el No de Obligacion en pignoracion de prestamos C/P,
        ' y lineas de sobregiro
        If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
            If txtCampo(0).Text = "5" Then
               If mskCuentacte.ClipText = "" Or mskCuentacte.ClipText = FMMascara("", VGMascaraCtaCte$) Then
                    MsgBox "El Nro. de cuenta corriente es mandatorio", 0 + 16, "Mensaje de Error"
                    mskCuentacte.Enabled = True
                    lbletiqueta(10).ForeColor = &H800000
                    mskCuentacte.SetFocus
                    Exit Sub
                End If
            Else
                If txtCampo(3).Text = "" Then
                    MsgBox "El número de obligación es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Enabled = True
                    lbletiqueta(8).ForeColor = &H800000
                    txtCampo(3).SetFocus
                    Exit Sub
                End If
            End If
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "217"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "B"
         PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (mskValor.Text)
         PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
         PMPasoValores sqlconn&, "@i_solicit", 0, SQLVARCHAR, (txtCampo(2).Text)
         PMPasoValores sqlconn&, "@i_plazo", 0, SQLINT2, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@o_fecha_ven", 1, SQLDATETIME, "01/01/1960"
         PMPasoValores sqlconn&, "@i_observacion", 0, SQLVARCHAR, (txtObservacion.Text)
                  
         'PMPasoValores sqlconn&, "@i_ngarantia", 0, SQLINT2, (txtCampo(3).Text)
         PMPasoValores sqlconn&, "@i_ngarantia", 0, SQLCHAR, (txtCampo(3).Text)
         
         PMPasoValores sqlconn&, "@i_nlinea_sob", 0, SQLVARCHAR, (txtCampo(4).Text)
         PMPasoValores sqlconn&, "@i_numcte", 0, SQLVARCHAR, (mskCuentacte.ClipText)

         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_bloq_val_ah", True, "Ok... Retención de Valores") Then
             PMChequea sqlconn&
             lblDescripcion(2).Caption = Format$(Left$(FMRetParam(sqlconn&, 1), 11), "Medium Date")
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
            MsgBox "El bloqueo de valor a la cuenta de ahorros fue ingresado satisfactoriamente", 0 + vbInformation, "Informacion"
        End If

    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        mskCuentacte.Text = FMMascara("", VGMascaraCtaAho$)
        Dim i As Integer
        For i = 0 To 3
            lblDescripcion(i).Caption = ""
        Next i
        For i% = 0 To 4
            txtCampo(i).Text = ""
        Next i
        txtObservacion.Text = ""
        mskValor.Format = VGDecimales$
        mskValor.Text = Format$(0, VGDecimales$)
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        mskCuenta.SetFocus
        txtCampo(1).Enabled = False
        txtCampo(3).Enabled = False
        txtCampo(4).Enabled = False
        mskCuentacte.Enabled = False
        lbletiqueta(5).ForeColor = &H808080
        lbletiqueta(8).ForeColor = &H808080
        lbletiqueta(9).ForeColor = &H808080
        lbletiqueta(10).ForeColor = &H808080
    Case 2
        'Salir
        Unload FTran217
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        Else
            PMLimpiaGrid grdPropietarios
        End If
    Case 4
        PLImprimir
    End Select
End Sub


Private Sub grdPropietarios_Click()
    grdPropietarios.Col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If
End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N" 'PCOELLO NO SE DEBE VALIDAR INACTIVIDAD
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    End If
End Sub

Private Sub mskCuentacte_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuentacte.SelStart = 0
    mskCuentacte.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuentacte_LostFocus()
    On Error Resume Next
    If mskCuentacte.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuentacte.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuentacte.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(3)
                 PMChequea sqlconn&
            Else
                mskCuentacte.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(3).Caption = ""
                mskCuentacte.SetFocus
            End If
        Else
            'MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuentacte.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(3).Caption = ""
            mskCuentacte.SetFocus
            Exit Sub
        End If
    End If

End Sub

Private Sub mskValor_GotFocus()
    If VGCodPais$ = "CO" Then
        FPrincipal!pnlHelpLine.Caption = " Valor del bloqueo"
    Else
        FPrincipal!pnlHelpLine.Caption = " Valor de la Pignoración"
    End If
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        'FPrincipal!pnlHelpLine.Caption = " Causa de la Retención [F5 Ayuda]"
        If VGCodPais$ = "CO" Then
            FPrincipal!pnlHelpLine.Caption = " Causa del Bloqueo [F5 Ayuda]"
        Else
            FPrincipal!pnlHelpLine.Caption = " Causa de la Pignoración [F5 Ayuda]"
        End If
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Plazo en días"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Nombre de quien solicita la Retención"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Número de la garantía"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Número de la línea de sobregiro"
    
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    txtCampo(1).Enabled = False
    txtCampo(3).Enabled = False
    txtCampo(4).Enabled = False
    mskCuentacte.Enabled = False
    lbletiqueta(5).ForeColor = &H808080
    lbletiqueta(8).ForeColor = &H808080
    lbletiqueta(9).ForeColor = &H808080
    lbletiqueta(10).ForeColor = &H808080
    If Keycode% = VGTeclaAyuda% And Index% = 0 Then
        VLPaso% = True
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "ah_causa_bloqueo_val"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
             PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(0).Text = VGACatalogo.Codigo$
            lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            If txtCampo(0).Text <> "" Then
                mskValor.SetFocus
            End If
            If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
               txtCampo(1).Enabled = True
               txtCampo(3).Enabled = True
               txtCampo(4).Enabled = True
               mskCuentacte.Enabled = True
               lbletiqueta(5).ForeColor = &H800000
               lbletiqueta(8).ForeColor = &H800000
               lbletiqueta(9).ForeColor = &H800000
               lbletiqueta(10).ForeColor = &H800000
            End If
        Else
            txtCampo(0).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(0).SetFocus
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 4     '0, 1, 3, 4
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 2
        KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    Case 3
        KeyAscii% = FMVAlidaTipoDato("U", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    txtCampo(1).Enabled = False
    txtCampo(3).Enabled = False
    txtCampo(4).Enabled = False
    mskCuentacte.Enabled = False
    lbletiqueta(5).ForeColor = &H808080
    lbletiqueta(8).ForeColor = &H808080
    lbletiqueta(9).ForeColor = &H808080
    lbletiqueta(10).ForeColor = &H808080
    If VLPaso% = False Then
        Select Case Index%
        Case 0
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ah_causa_bloqueo_val"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(0).Text)
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                     If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
                        txtCampo(1).Enabled = True
                        txtCampo(3).Enabled = True
                        txtCampo(4).Enabled = True
                        mskCuentacte.Enabled = True
                        lbletiqueta(5).ForeColor = &H800000
                        lbletiqueta(8).ForeColor = &H800000
                        lbletiqueta(9).ForeColor = &H800000
                        lbletiqueta(10).ForeColor = &H800000
                     End If
                Else
                    VLPaso% = True
                    txtCampo(0).Text = ""
                    lblDescripcion(1).Caption = ""
                    txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(1).Caption = ""
            End If
        End Select
    End If
End Sub

Private Sub txtObservacion_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime los datos de la pantalla luego de haber
'            transmitido el bloqueo
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-05      D. Villagómez   Emisión Inicial
'*************************************************************
    Dim banderaContinuar  As Boolean
    Dim VTMsg As String
    
    banderaContinuar = True
    If VGCodPais$ = "CO" Then
        VTMsg = "Esta seguro de imprimir el resultado del bloqueo de valores?"
    Else
        VTMsg = "Esta seguro de imprimir el resultado de la Pignoración de valores?"
    End If
    
    If MsgBox(VTMsg$, 4 + 32 + 0, "Mensaje del Sistema") = 7 Then
        banderaContinuar = False
    End If
   
    If (banderaContinuar = True) Then
        Screen.MousePointer = 11
        FMCabeceraReporte VGBanco$, Date, "BLOQUEO DE VALORES EN CUENTAS DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        Printer.FontBold = True
        Printer.FontSize = 8
        Printer.Print "  Número de Cuenta           :"; Tab(32); mskCuenta.Text
        Printer.Print ""
        Printer.Print "  Nombre de la Cuenta        :"; Tab(32); lblDescripcion(0).Caption
        Printer.Print ""
        If VGCodPais$ = "CO" Then
            Printer.Print "  Causa del Bloqueo          :"; Tab(32); txtCampo(0).Text; "  "; lblDescripcion(1).Caption
        Else
            Printer.Print "  Causa de la Pignoración    :"; Tab(32); txtCampo(0).Text; "  "; lblDescripcion(1).Caption
        End If
        Printer.Print ""
        If VGCodPais$ = "CO" Then
            Printer.Print "  Valor del Bloqueo          :"; Tab(32); Format$(mskValor.Text, "#,##0.00")
        Else
            Printer.Print "  Valor de la Pignoración    :"; Tab(32); Format$(mskValor.Text, "#,##0.00")
        End If
        Printer.Print ""
        Printer.Print "  Plazo en Días              :"; Tab(32); txtCampo(1).Text
        Printer.Print ""
        Printer.Print "  Solicitado por             :"; Tab(32); txtCampo(2).Text
        Printer.Print ""
        Printer.Print "  Fecha de Vencimiento       :"; Tab(32); lblDescripcion(2).Caption
        Printer.Print ""
        Printer.Print "  Observaciones              :"; Tab(32); txtObservacion.Text
        Printer.Print ""
        Printer.Print "  Número de Garantía         :"; Tab(32); txtCampo(3).Text
        Printer.Print ""
        Printer.Print "  Número línea de sobregiro  :"; Tab(32); txtCampo(4).Text
        Printer.Print ""
        Printer.Print "  Número cuenta corriente    :"; Tab(32); mskCuentacte.Text
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________                                                 _________________"
        Printer.Print "  PROCESADO POR                                                     AUTORIZADO POR "
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
'        Printer.Print "_________________"
'        Printer.Print "FIRMA DEL CLIENTE"

        Printer.EndDoc
        Screen.MousePointer = 0
        
    Else 'si el usuario escogió NO en la pregunta
        Exit Sub
        
    End If
End Sub



