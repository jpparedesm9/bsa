VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran303 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Cobro de Valores en Suspenso"
   ClientHeight    =   5325
   ClientLeft      =   900
   ClientTop       =   2085
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
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1117
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3111"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7890
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   12
      Top             =   90
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8100
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   11
      Top             =   90
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   1
      Top             =   10
      WhatsThisHelpID =   2000
      Width           =   875
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
   Begin MSGrid.Grid grdValores 
      Height          =   4230
      Left            =   15
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   1080
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   7462
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
      Index           =   2
      Left            =   8415
      TabIndex        =   6
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
      Index           =   1
      Left            =   8415
      TabIndex        =   5
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
      Index           =   0
      Left            =   8415
      TabIndex        =   3
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2205
      TabIndex        =   0
      Top             =   60
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   4
      Top             =   780
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valores en Suspenso Vigentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   75
      TabIndex        =   10
      Top             =   825
      WhatsThisHelpID =   5296
      Width           =   2730
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -45
      X2              =   8370
      Y1              =   750
      Y2              =   750
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   2205
      TabIndex        =   9
      Top             =   360
      UseMnemonic     =   0   'False
      Width           =   6150
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta de ahorro:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   8
      Top             =   60
      WhatsThisHelpID =   5254
      Width           =   2235
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   60
      TabIndex        =   7
      Top             =   360
      WhatsThisHelpID =   5265
      Width           =   1935
   End
End
Attribute VB_Name = "FTran303"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN303.frm
' NOMBRE LOGICO:    FTran303
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
' Permite realizar el Cobro de Valores en Suspenso
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLFormatoFecha As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir
        PLTransmitir
    Case 1
        'Limpiar
        PLLimpiar
    Case 2
        'Salir
        Unload FTran303
    Case 3:
        'Buscar
        PLBuscar
    Case 4
        'Siguientes
        PLSiguientes
    End Select
End Sub

Private Sub Form_Load()
    Dim VLBandera As Boolean
    FTran303.Left = 0   '15
    FTran303.Top = 0   '15
    FTran303.Width = 9450   '9420
    FTran303.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    'For I% = 0 To 1
        'mskfecha(I%).Mask = FMMascaraFecha(VLFormatoFecha$)
        'mskfecha(I%).Text = Format$(VGFecha$, VLFormatoFecha$)
    'Next I%
    VLBandera = True
    If VGCB = True Then
        lbletiqueta(1).Caption = "Registros Vigentes"
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    VGCB = False
End Sub

Private Sub grdValores_Click()
    grdValores.Col = 0
    grdValores.SelStartCol = 1
    grdValores.SelEndCol = grdValores.Cols - 1
    If grdValores.Row = 0 Then
        grdValores.SelStartRow = 1
        grdValores.SelEndRow = 1
    Else
        grdValores.SelStartRow = grdValores.Row
        grdValores.SelEndRow = grdValores.Row
    End If
End Sub

Private Sub grdValores_DblClick()
    If grdValores.Rows <= 2 Then
        grdValores.Row = 1
        grdValores.Col = 1
        If Trim$(grdValores.Text) = "" Then
            MsgBox "No existen valores en suspenso ha ser cobrados", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If
    PMMarcarRegistro
End Sub

Private Sub grdValores_KeyUp(Keycode As Integer, Shift As Integer)
    grdValores.Col = 0
    grdValores.SelStartCol = 1
    grdValores.SelEndCol = grdValores.Cols - 1
    If grdValores.Row = 0 Then
        grdValores.SelStartRow = 1
        grdValores.SelEndRow = 1
    Else
        grdValores.SelStartRow = grdValores.Row
        grdValores.SelEndRow = grdValores.Row
    End If
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If VGCB = True Then
                PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
             End If
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdValores

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

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid con los datos retornados por el
'            stored procedure.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
        Dim i As Integer
        If mskCuenta.ClipText <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "303"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, "0"
             PMPasoValores sqlconn&, "@i_linea", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cobro_vsah", True, " Ok... Cobro de Valores en suspenso") Then
                 PMMapeaGrid sqlconn&, grdValores, False
                 PMChequea sqlconn&

                If Val(grdValores.Tag) < 20 Then
                    cmdBoton(4).Enabled = False
                Else
                    cmdBoton(4).Enabled = True
                End If
                
                grdValores.Row = 1
                grdValores.Col = 1
            End If

            If grdValores.Rows > 0 Then
                
                For i = 1 To grdValores.Rows - 1
                    grdValores.Col = 0
                    grdValores.Row = i
                    grdValores.Text = CStr(grdValores.Row)
                    grdValores.Col = 1
                    If grdValores.Text <> "" Then
                      grdValores.Col = 0
                      grdValores.Picture = picVisto(0)
                    Else
                      grdValores.Col = 0
                      grdValores.Picture = picVisto(1)
                    End If
                Next i
               
            End If
        Else
            MsgBox "Debe ingresar el número de cuenta"
            mskCuenta.SetFocus
        End If
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        cmdBoton(3).Enabled = True
        cmdBoton(4).Enabled = False
        PMLimpiaGrid grdValores
        grdValores.Row = 1
        grdValores.Col = 0
        If grdValores.Picture = picVisto(0) Then
            grdValores.Text = Str$(grdValores.Row)
            grdValores.Picture = picVisto(1)
        End If
        mskCuenta.SetFocus
        
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid con los siguientes 20 registros
'            retornados por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
       Dim i As Integer
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "303"
       PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
       PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
      grdValores.Col = 1
       PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, grdValores.Text
       PMPasoValores sqlconn&, "@i_linea", 0, SQLCHAR, "S"
       PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cobro_vsah", True, " Ok... Cobro de Valores en suspenso") Then
             PMMapeaGrid sqlconn&, grdValores, True
             PMChequea sqlconn&

            If Val(grdValores.Tag) < 20 Then
                cmdBoton(4).Enabled = False
            Else
                cmdBoton(4).Enabled = True
            End If
                grdValores.Row = 1
                grdValores.Col = 1
        End If

        If grdValores.Rows > 0 Then
            For i = 1 To grdValores.Rows - 1
                grdValores.Col = 0
                grdValores.Row = i
                grdValores.Text = CStr(grdValores.Row)
                grdValores.Col = 1
            
                If grdValores.Text <> "" Then
                    grdValores.Col = 0
                    grdValores.Picture = picVisto(0)
                Else
                    grdValores.Col = 0
                    grdValores.Picture = picVisto(1)
                End If
            Next i
        End If
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Transmite los datos del Cobro de valores en
'            suspenso
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim i As Integer
  Dim VTcontador As Integer
  
  If Trim$(mskCuenta.ClipText) = "" Then
      MsgBox "El número de Cuenta de Ahorro es mandatorio", 0 + 16, "Mensaje de Error"
      mskCuenta.SetFocus
      Exit Sub
  End If
  VTcontador = 0
  If Val(grdValores.Tag) > 0 Then
    For i = 1 To (grdValores.Rows - 1)
      grdValores.Row = i
      grdValores.Col = 0
      If grdValores.Picture = picVisto(0) Then 'Cuando estan con el VISTITO
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "303"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         If VGCB = True Then
            PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
         End If
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
        grdValores.Col = 1
         PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, grdValores.Text
        grdValores.Col = 2
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, grdValores.Text
         PMPasoValores sqlconn&, "@i_linea", 0, SQLCHAR, "S"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cobro_vsah", True, "Ok... Cobro de valores en Suspenso") Then
           PMChequea sqlconn&
          VTcontador = VTcontador + 1
        End If
      End If
    Next i
  End If
  If VTcontador > 0 Then
    PLBuscar
  End If
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Seleccionar y quitar la Seleccion de una fila del
'            grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VLPaso As Boolean
    Dim VLBandera As Boolean
    grdValores.Col = 0
    If grdValores.Picture = picVisto(1) Then
        If VLBandera Then
            grdValores.Text = Str$(grdValores.Row)
            grdValores.Picture = picVisto(0)
            VLBandera = False
        End If
    Else
        grdValores.Text = Str$(grdValores.Row)
        grdValores.Picture = picVisto(1)
        VLBandera = True
    End If
    VLPaso = True
End Sub


