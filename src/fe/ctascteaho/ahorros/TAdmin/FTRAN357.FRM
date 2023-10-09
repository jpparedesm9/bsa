VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran357 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Solicitudes de Apertura Cuenta de Ahorros"
   ClientHeight    =   5910
   ClientLeft      =   150
   ClientTop       =   1650
   ClientWidth     =   9330
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
   HelpContextID   =   1046
   LinkTopic       =   "Form5"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5910
   ScaleWidth      =   9330
   Tag             =   "3114"
   Begin VB.TextBox txtcampo 
      Height          =   285
      Index           =   3
      Left            =   1872
      MaxLength       =   5
      TabIndex        =   3
      Top             =   684
      Width           =   800
   End
   Begin VB.TextBox txtcampo 
      Height          =   285
      Index           =   2
      Left            =   1872
      MaxLength       =   5
      TabIndex        =   4
      Top             =   984
      Width           =   800
   End
   Begin VB.CommandButton cmdHab 
      Caption         =   "Hab"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8520
      TabIndex        =   20
      Tag             =   "354"
      Top             =   360
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Frame frmCriterio 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   450
      Left            =   1275
      TabIndex        =   10
      Top             =   1560
      Width           =   7080
      Begin Threed.SSOption optVigentes 
         Height          =   195
         Index           =   2
         Left            =   3810
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   165
         WhatsThisHelpID =   5359
         Width           =   1035
         _Version        =   65536
         _ExtentX        =   1826
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Negadas"
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
      Begin Threed.SSOption optVigentes 
         Height          =   195
         Index           =   1
         Left            =   2025
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   165
         WhatsThisHelpID =   5358
         Width           =   1170
         _Version        =   65536
         _ExtentX        =   2064
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Aprobadas"
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
      Begin Threed.SSOption optVigentes 
         Height          =   195
         Index           =   0
         Left            =   225
         TabIndex        =   6
         Top             =   165
         WhatsThisHelpID =   5357
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Solicitadas"
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
      Begin Threed.SSOption optVigentes 
         Height          =   195
         Index           =   3
         Left            =   5490
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   165
         WhatsThisHelpID =   5360
         Width           =   1275
         _Version        =   65536
         _ExtentX        =   2249
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Cta. Abierta"
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
   Begin VB.TextBox txtcampo 
      Height          =   285
      Index           =   1
      Left            =   1872
      MaxLength       =   5
      TabIndex        =   5
      Tag             =   "371"
      Top             =   1284
      Width           =   800
   End
   Begin VB.TextBox txtcampo 
      Height          =   285
      Index           =   0
      Left            =   1872
      MaxLength       =   5
      TabIndex        =   2
      Top             =   330
      Width           =   800
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   4
      Left            =   8412
      TabIndex        =   12
      Top             =   2770
      WhatsThisHelpID =   2020
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
   End
   Begin MSGrid.Grid grdValores 
      Height          =   3732
      Left            =   12
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   2100
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   6583
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
      Height          =   756
      Index           =   0
      Left            =   8412
      TabIndex        =   11
      Top             =   3540
      WhatsThisHelpID =   2007
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   1
      Left            =   8412
      TabIndex        =   13
      Top             =   4308
      WhatsThisHelpID =   2003
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   2
      Left            =   8412
      TabIndex        =   14
      Top             =   5076
      WhatsThisHelpID =   2008
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
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
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   1
      Left            =   5712
      TabIndex        =   1
      Top             =   36
      Width           =   1344
      _ExtentX        =   2355
      _ExtentY        =   529
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   0
      Left            =   1872
      TabIndex        =   0
      Top             =   36
      Width           =   1356
      _ExtentX        =   2381
      _ExtentY        =   529
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   5
      Left            =   90
      TabIndex        =   26
      Top             =   72
      WhatsThisHelpID =   5172
      Width           =   1248
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   3
      Left            =   4452
      TabIndex        =   25
      Top             =   72
      WhatsThisHelpID =   5173
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   288
      Index           =   2
      Left            =   2688
      TabIndex        =   24
      Top             =   984
      Width           =   5650
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   288
      Index           =   1
      Left            =   2688
      TabIndex        =   23
      Top             =   684
      Width           =   5650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Territorial:"
      ForeColor       =   &H00800000&
      Height          =   252
      Index           =   4
      Left            =   96
      TabIndex        =   22
      Top             =   696
      Width           =   888
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Zona:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   2
      Left            =   96
      TabIndex        =   21
      Top             =   996
      Width           =   516
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8400
      Y1              =   650
      Y2              =   650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   1
      Left            =   96
      TabIndex        =   19
      Top             =   1632
      WhatsThisHelpID =   5084
      Width           =   528
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -48
      X2              =   8367
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Agencia:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   6
      Left            =   96
      TabIndex        =   18
      Top             =   1296
      WhatsThisHelpID =   5005
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Solicitud:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   0
      Left            =   90
      TabIndex        =   17
      Top             =   396
      WhatsThisHelpID =   5250
      Width           =   1512
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5880
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   288
      Index           =   0
      Left            =   2688
      TabIndex        =   16
      Top             =   1284
      Width           =   5650
   End
End
Attribute VB_Name = "FTran357"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran357.frm
' NOMBRE LOGICO:    FTran357
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
' Consulta de Solicitudes de Apertura
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Boolean
Dim VLSolic As Integer
Private Sub cmdBoton_Click(Index As Integer)
   Dim i As Integer
   Dim VTFDesde As String
   Dim VTFHasta As String

    Select Case Index
    Case 0
        ' Fecha de inicio de la consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha de inicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de fin de la consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha de fin es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If
        
        'Transmitir
        If txtCampo(0).Text <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "356"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
             VLSolic = Val(txtCampo(0).Text) '- 1
             PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, Str$(VLSolic)
             If optVigentes(0).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "SO"
                frmCriterio.Enabled = False
             End If
             If optVigentes(1).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "AP"
                frmCriterio.Enabled = False
             End If
             If optVigentes(2).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "NE"
                frmCriterio.Enabled = False
             End If
             If optVigentes(3).Value = True Then
                PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "PR"
                frmCriterio.Enabled = False
             End If
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         
             VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha, CGFormatoBase)
             PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
             VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
             PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
             PMPasoValores sqlconn&, "@i_zona", 0, SQLINT4, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_territorial", 0, SQLINT4, txtCampo(3).Text
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta de solicitudes") Then
                PMMapeaGrid sqlconn&, grdValores, False
                PMChequea sqlconn&
                grdValores.ColAlignment(1) = 2
                grdValores.ColAlignment(3) = 1
                grdValores.ColAlignment(5) = 1
                grdValores.ColWidth(1) = 500
                grdValores.ColWidth(2) = 3000
                grdValores.ColWidth(3) = 500
                grdValores.ColWidth(4) = 1500
                grdValores.ColWidth(5) = 900
                grdValores.ColWidth(6) = 900
                grdValores.ColWidth(7) = 1500
                grdValores.ColWidth(8) = 900
                grdValores.ColWidth(9) = 600
                
                If (grdValores.Rows - 1) >= 20 Then
                    cmdBoton_Click (4)
                End If
            End If
        Else
            MsgBox "El número de solicitud inicial es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
        End If
    Case 1
        'Limpiar
        txtCampo(1).Text = VGOficina
        PMCatalogo "V", "cl_oficina", FTran357!txtCampo(1), FTran357!lblDescripcion(0)
        VLPaso = True
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(0).Text = "0"
        txtCampo(0).SetFocus
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        For i = 0 To 1
            mskValor(i).Mask = ""
            mskValor(i).Text = ""
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
        Next i
        
        PMLimpiaGrid grdValores
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        frmCriterio.Enabled = True
        optVigentes(0).Value = True
    
    Case 2
        'Salir
        Unload FTran357
    Case 4
        'Siguientes
        If txtCampo(0).Text <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "356"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
            PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
            
            If optVigentes(0).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "SO"
            End If
            If optVigentes(1).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "AP"
            End If
            If optVigentes(2).Value = True Then
                 PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "NE"
            End If
            If optVigentes(3).Value = True Then
                PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "PR"
                frmCriterio.Enabled = False
            End If
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
            grdValores.Col = 1
            grdValores.Row = grdValores.Rows - 1
            PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT2, (grdValores.Text)
            PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
           
            VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha, CGFormatoBase)
            PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
            VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
            PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
            PMPasoValores sqlconn&, "@i_zona", 0, SQLINT4, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_territorial", 0, SQLINT4, txtCampo(3).Text
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta de Solicitudes") Then
                PMMapeaGrid sqlconn&, grdValores, True
                PMChequea sqlconn&
                If (grdValores.Rows - 1) Mod 20 = 0 Then
                    cmdBoton(4).Enabled = True
                Else
                    cmdBoton(4).Enabled = False
                End If
            End If
        Else
            MsgBox "El código de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        End If
    End Select
End Sub

Private Sub Form_Load()
Dim i As Integer
    FTran357.Left = 0
    FTran357.Top = 0
    FTran357.Width = 9450
    FTran357.Height = 6315
    PMLoadResStrings Me
    PMLoadResIcons Me
    txtCampo(0).Text = 0
    txtCampo(1).Text = VGOficina
    PMCatalogo "V", "cl_oficina", FTran357!txtCampo(1), FTran357!lblDescripcion(0)
    VLPaso = True
    txtCampo(2).Text = ""
    txtCampo(3).Text = ""
    optVigentes(0).Value = True
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
    Next i
    cmdBoton(4).Visible = False
    PMObjetoSeguridad txtCampo(1)
    PMObjetoSeguridad cmdHab
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
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
    Dim a As String
    If grdValores.Cols <= 2 Then Exit Sub
    grdValores.Col = 8
    If grdValores.Text = "SO" Then
       If cmdHab.Enabled Then
          grdValores.Col = 1
          FTRAN354!txtCampo(6) = grdValores.Text
          FTRAN354.txtCampo_LostFocus 6
          FTRAN354.Show
       Else
          a = MsgBox("No esta autorizado para actualizar la solicitud", vbCritical, "Solicitudes - Autorización")
       End If
    End If
    If grdValores.Text = "AP" Then
        grdValores.Col = 1
        FTran201.Show
        FTran201!txtCampo(14) = grdValores.Text
        FTran201.PLBuscar
    End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Fecha inicial de la consulta [" & VGFormatoFecha & "]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    mskValor(Index).SelStart = 0
    mskValor(Index).SelLength = Len(mskValor(Index).Text)
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'PORPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index    Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
Dim VTValido As Integer
Dim i As Integer
Dim VTDias As Integer
    On Error Resume Next
    Select Case Index
    Case 0, 1
        If mskValor(Index).ClipText <> "" Then
            VTValido = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index).SetFocus
                Exit Sub
            End If
        Else
            For i = 0 To 1
                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            Next i
        End If
        
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
                Next i
                mskValor(Index).SetFocus
                Exit Sub
            End If
        End If
    End Select
End Sub



Private Sub txtCampo_Change(Index As Integer)
    Select Case Index
    Case 0, 1, 2, 3
        VLPaso = False
    End Select
    
     If Index = 1 Then
        lblDescripcion(0).Caption = ""
    End If

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Número de solicitud desde"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código de agencia [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Código de Zona"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Codigo Territorial"
    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda Then
        Select Case Index
        Case 1
            ' F5 para ayuda de Oficina a consultar
            txtCampo(1).Text = ""
            PMCatalogo "A", "cl_oficina", FTran357!txtCampo(1), FTran357!lblDescripcion(0)
            VLPaso = False
        Case 3 'territorial
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "C"
       
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_oficina", True, "Ok... Consulta de Territorial") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
             FCatalogo.Show 1
             txtCampo(3).Text = VGACatalogo.Codigo
             lblDescripcion(1).Caption = VGACatalogo.Descripcion
         Else
                txtCampo(3).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(3).SetFocus
           
         End If
        Case 2 'zona
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "O"
       
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_oficina", True, "Ok... Consulta de zona") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
             FCatalogo.Show 1
             txtCampo(2).Text = VGACatalogo.Codigo
             lblDescripcion(2).Caption = VGACatalogo.Descripcion
         Else
                txtCampo(2).Text = ""
                lblDescripcion(2).Caption = ""
                txtCampo(2).SetFocus
           
         End If

        End Select
    End If

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index
    Case 1
        If txtCampo(1).Text <> "" Then
            If txtCampo(1).Text >= 32000 Then
                MsgBox "La Sucursal no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
            PMCatalogo "V", "cl_oficina", FTran357!txtCampo(1), FTran357!lblDescripcion(0)
            VLPaso = True
        End If
    Case 3 'territorial
    If VLPaso = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "VS"
                 PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "R"
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(3).Text
                 If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_oficina", True, "Ok... Consulta de TERRITORIAL") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                Else
                    VLPaso = True
                    txtCampo(3).Text = ""
                    lblDescripcion(1).Caption = ""
                    If txtCampo(3).Enabled = True Then
                        txtCampo(3).SetFocus
                    End If
                End If
            Else
                lblDescripcion(1).Caption = ""
            End If
     End If
     Case 2 'zona
    If VLPaso = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "VS"
                 PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "Z"
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_oficina", True, "Ok... Consulta de ZONA") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                Else
                    VLPaso = True
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Caption = ""
                    If txtCampo(2).Enabled = True Then
                        txtCampo(2).SetFocus
                    End If
                End If
            Else
                lblDescripcion(2).Caption = ""
            End If
     End If
    End Select
   
End Sub


