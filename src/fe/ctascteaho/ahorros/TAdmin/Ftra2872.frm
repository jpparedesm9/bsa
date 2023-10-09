VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form Ftran2872 
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Mantenimiento de Funcionarios Autorizantes de ND/NC"
   ClientHeight    =   5340
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9300
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5340
   ScaleWidth      =   9300
   Tag             =   "3868"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   2235
      MaxLength       =   5
      TabIndex        =   0
      Top             =   60
      Width           =   1170
   End
   Begin MSGrid.Grid grdAutorizantes 
      Height          =   4305
      Left            =   50
      TabIndex        =   6
      Top             =   960
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14658
      _ExtentY        =   7594
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
      Index           =   4
      Left            =   8420
      TabIndex        =   3
      Top             =   3060
      WhatsThisHelpID =   2003
      Width           =   870
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
      Index           =   5
      Left            =   8420
      TabIndex        =   1
      Top             =   0
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8420
      TabIndex        =   5
      Top             =   4590
      WhatsThisHelpID =   2008
      Width           =   870
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
      Index           =   0
      Left            =   8420
      TabIndex        =   4
      Top             =   3825
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Left            =   8420
      TabIndex        =   2
      Tag             =   "15155"
      Top             =   2280
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   0
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre del Autorizante:"
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
      Left            =   90
      TabIndex        =   10
      Top             =   360
      WhatsThisHelpID =   5219
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Código del Autorizante:"
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
      Left            =   90
      TabIndex        =   9
      Top             =   60
      WhatsThisHelpID =   5218
      Width           =   2070
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8385
      Y1              =   675
      Y2              =   675
   End
   Begin VB.Label lblDescripcion 
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
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2235
      TabIndex        =   8
      Top             =   360
      UseMnemonic     =   0   'False
      Width           =   6120
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de funcionarios autorizantes ND/NC"
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
      Left            =   90
      TabIndex        =   7
      Top             =   720
      WhatsThisHelpID =   5220
      Width           =   3630
   End
End
Attribute VB_Name = "Ftran2872"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14-Aug-10
'*************************************************************
' ARCHIVO:          FTRA2872.frm
' NOMBRE LOGICO:    FTran2872
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
' Permite realizar el Mantenimiento de Funcionarios que podran
' ser autorizantes de Notas de Debitos y Credito
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 12-Ago-05      L. Bernuil      Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Integer

Private Sub Form_Load()
    Ftran2872.Left = 0   '15
    Ftran2872.Top = 0   '15
    Ftran2872.Width = 9450    '9420
    Ftran2872.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    txtCampo(0).Text = ""
    lblDescripcion(0).Caption = ""
    
    cmdBoton(1).Enabled = False 'LBM
    
    cmdBoton_Click (5)
    
End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub TxtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = False
    End Select
End Sub
Private Sub TxtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de Funcionario [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub TxtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0
            FGFuncionarios.Show 1
            If VGBusqueda(1) <> "" Then
                txtCampo(Index%).Text = VGBusqueda(1)
                lblDescripcion(0).Caption = VGBusqueda(2)
                VLPaso% = True
            End If
        End Select
    End If
End Sub
Private Sub TxtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0 'Transmitir
            PLTransmitir
        Case 1 'Eliminar
            PLEliminar
        Case 4 'Limpiar
            PLLimpiar
        Case 2 'Salir
            Unload Ftran2872
        Case 5 'Buscar
            PLBuscar
    End Select
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Enviar los datos ingresados a la base de datos
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 12-Ago-05      L.Bernuil       Emisión Inicial
'*************************************************************
         
    'Validacion de Campos Mandatorios
    If txtCampo(0).Text = "" Then
        MsgBox "El código del funcionario autorizante es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "700"   '2872
    PMPasoValores sqlconn&, "@i_autorizante", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_ejecutor", 0, SQLINT2, "0"
    PMPasoValores sqlconn&, "@i_tipo_f", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mant_fun_aut", True, "Ok... Creación de funcionario autorizante") Then
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
    Else
        PLLimpiar
        PLBuscar
    End If
End Sub
Private Sub PLLimpiar()

    txtCampo(0).Enabled = True
    txtCampo(0).Text = ""

    lblDescripcion(0).Caption = ""

    PMLimpiaGrid grdAutorizantes
    
    cmdBoton(1).Enabled = False
    cmdBoton(0).Enabled = True
    
    VLPaso% = True
    If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
    PLBuscar
End Sub
Private Sub PLBuscar()
    Dim VTRegistros As Integer
    Dim VTFlag As Integer
    Dim VTSecuencial As Integer
    Dim VTModo As Integer
    PMLimpiaGrid grdAutorizantes

    If txtCampo(0).Text = "" Then 'Buscar todos los registros
        VTRegistros% = 20
        VTFlag% = False
        VTSecuencial = -1
        VTModo% = 0

        While VTRegistros% = 20
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "699"  '2874
            PMPasoValores sqlconn&, "@i_autorizante", 0, SQLINT2, VTSecuencial
            PMPasoValores sqlconn&, "@i_ejecutor", 0, SQLINT2, "0"
            PMPasoValores sqlconn&, "@i_tipo_f", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mant_fun_aut", True, "Ok... Consulta de funcionarios autorizante") Then
                PMMapeaGrid sqlconn&, grdAutorizantes, VTFlag%
                PMChequea sqlconn&
                VTFlag% = True

                VTRegistros% = Val(grdAutorizantes.Tag)
                grdAutorizantes.Row = grdAutorizantes.Rows - 1
                grdAutorizantes.col = 1
                VTSecuencial = grdAutorizantes.Text
            Else
                VTRegistros% = 0
            End If
        Wend

        If grdAutorizantes.Rows <= 2 Then
            grdAutorizantes.Row = 1
            grdAutorizantes.col = 1

            If Trim$(grdAutorizantes.Text) = "" Then
                cmdBoton(1).Enabled = False
                cmdBoton(0).Enabled = True
            Else
                grdAutorizantes.ColWidth(1) = 1000
                grdAutorizantes.ColWidth(2) = 4500
                cmdBoton(0).Enabled = False
            End If
        End If

    Else    'Buscar el registro ingresado
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "699"  '2874
        PMPasoValores sqlconn&, "@i_autorizante", 0, SQLINT2, (txtCampo(0).Text)
        PMPasoValores sqlconn&, "@i_ejecutor", 0, SQLINT2, "0"
        PMPasoValores sqlconn&, "@i_tipo_f", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mant_fun_aut", True, "Ok... Consulta de funcionario autorizante") Then
            PMMapeaGrid sqlconn&, grdAutorizantes, False
            PMChequea sqlconn&
            'cmdBoton(0).Enabled = False
            
            If grdAutorizantes.Rows <= 2 Then
                grdAutorizantes.Row = 1
                grdAutorizantes.col = 1

                If Trim$(grdAutorizantes.Text) = "" Then
                    cmdBoton(1).Enabled = False
                    cmdBoton(0).Enabled = True
                Else
                    'cmdBoton(1).Enabled = True
                    cmdBoton(0).Enabled = False
                End If
            Else
                'cmdBoton(1).Enabled = True
                cmdBoton(0).Enabled = False
            End If
            
        Else
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = False
        End If
    End If
End Sub
Private Sub PLEliminar()
    'Validacion de Campos Mandatorios
    If txtCampo(0).Text = "" Then
        MsgBox "El código del funcionario autorizante es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "701"  '2873
    PMPasoValores sqlconn&, "@i_autorizante", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_ejecutor", 0, SQLINT2, "0"
    PMPasoValores sqlconn&, "@i_tipo_f", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mant_fun_aut", True, "Ok... Eliminación de funcionario autorizante") Then
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
    Else
        PLLimpiar
        PLBuscar
    End If
End Sub
Private Sub TxtCampo_LostFocus(Index As Integer)
    Select Case Index
        Case 0
            ' Funcionario
            If VLPaso% = False And txtCampo(Index%).Text <> "" Then
                txtCampo(Index%).Text = Trim$(txtCampo(Index%).Text)

                ' Validacion del Tipo de dato
                If Val(txtCampo(Index%).Text) > 32000 Then
                    MsgBox "Tipo de Dato inválido", 0 + 16, "Mensaje de Error"
                    lblDescripcion(Index%).Caption = ""
                    txtCampo(Index%).SetFocus
                    Exit Sub
                End If
                
                'Transaccion de consulta de funcionario por valor
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
                PMPasoValores sqlconn&, "@i_funcionario", 0, SQLINT4&, (txtCampo(Index%).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1577"
                
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_funcionario", True, "Ok.. Consulta de funcionario") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                    PMChequea sqlconn&
                    VLPaso% = True
                Else
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                    If txtCampo(Index%).Enabled And txtCampo(Index%).Visible Then txtCampo(Index%).SetFocus
                    VLPaso% = True
                    
                    PLBuscar
                End If
            End If
    End Select
End Sub
Private Sub grdAutorizantes_Click()
    grdAutorizantes.col = 0
    grdAutorizantes.SelStartCol = 1
    grdAutorizantes.SelEndCol = grdAutorizantes.Cols - 1
    If grdAutorizantes.Row = 0 Then
        grdAutorizantes.SelStartRow = 1
        grdAutorizantes.SelEndRow = 1
    Else
        grdAutorizantes.SelStartRow = grdAutorizantes.Row
        grdAutorizantes.SelEndRow = grdAutorizantes.Row
    End If
End Sub
Private Sub grdAutorizantes_DblClick()
    If (grdAutorizantes.Rows <= 2) Then
        grdAutorizantes.Row = 1
        grdAutorizantes.col = 1
        
        If Trim$(grdAutorizantes.Text) = "" Then
            MsgBox "No existen funcionarios autorizantes", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    grdAutorizantes.col = 1
    txtCampo(0).Text = grdAutorizantes.Text
    grdAutorizantes.col = 2
    lblDescripcion(0).Caption = grdAutorizantes.Text
    
    cmdBoton(0).Enabled = False
    cmdBoton(1).Enabled = True

    txtCampo(0).Enabled = False
End Sub


