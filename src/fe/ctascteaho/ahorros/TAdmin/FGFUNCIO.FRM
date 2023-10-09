VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FGFuncionarios 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Listado General de Funcionarios"
   ClientHeight    =   4440
   ClientLeft      =   510
   ClientTop       =   1275
   ClientWidth     =   8340
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
   LinkMode        =   1  'Source
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4440
   ScaleWidth      =   8340
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2430
      MaxLength       =   30
      TabIndex        =   4
      Text            =   "OFI%"
      Top             =   495
      Width           =   4860
   End
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   3
      Left            =   1200
      TabIndex        =   3
      Top             =   645
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   397
      _StockProps     =   78
      Caption         =   "Cargo"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Value           =   -1  'True
   End
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   2
      Left            =   1200
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   390
      Width           =   1035
      _Version        =   65536
      _ExtentX        =   1826
      _ExtentY        =   397
      _StockProps     =   78
      Caption         =   "Login"
      ForeColor       =   0
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
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   1
      Left            =   135
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   645
      Width           =   1305
      _Version        =   65536
      _ExtentX        =   2302
      _ExtentY        =   397
      _StockProps     =   78
      Caption         =   "Nombre"
      ForeColor       =   0
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
   Begin Threed.SSOption optOpcion 
      Height          =   225
      Index           =   0
      Left            =   135
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   390
      Width           =   1305
      _Version        =   65536
      _ExtentX        =   2302
      _ExtentY        =   397
      _StockProps     =   78
      Caption         =   "Código"
      ForeColor       =   0
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
   Begin MSGrid.Grid grdFuncionarios 
      Height          =   3210
      Left            =   30
      TabIndex        =   5
      Top             =   1215
      Width           =   7335
      _Version        =   65536
      _ExtentX        =   12939
      _ExtentY        =   5662
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
      Left            =   7440
      TabIndex        =   6
      Top             =   15
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   7440
      TabIndex        =   7
      Top             =   780
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guiente"
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
      Left            =   7440
      TabIndex        =   9
      Top             =   3675
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
      Index           =   2
      Left            =   7440
      TabIndex        =   8
      Top             =   2910
      WhatsThisHelpID =   2002
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
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
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "[Código] : "
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4155
      TabIndex        =   13
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
      TabIndex        =   12
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
      TabIndex        =   11
      Top             =   135
      Width           =   2145
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Funcionarios :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   10
      Top             =   1005
      Width           =   1215
   End
   Begin VB.Line linLinea 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   7395
      Y1              =   990
      Y2              =   975
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
Attribute VB_Name = "FGFuncionarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   ARCHIVO:        FGFUNCIO.FRM
'   NOMBRE LOGICO:  FGFuncionarios
'   PRODUCTO:       Subsistema de Seguridad
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
'                       PROPOSITO
' Descripcion:  Forma de Busqueda de Funcionarios
'*********************************************************
'                       MODIFICACIONES
'   FECHA         AUTOR            RAZON
'   08/Feb/94     Fabián Espinosa  Emision Inicial
'*********************************************************

Private Sub cmdBoton_Click(Index As Integer)
'*********************************************************
'PROPOSITO: Botones de control de la forma
'INPUT   :  Index% Indice del Boton
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    Select Case Index%
    Case 0  ' Busqueda
        
        If optOpcion(0).Value = True Then
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "1"
        Else
            If optOpcion(1).Value = True Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "2"
            Else
                If optOpcion(2).Value = True Then
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "3"
                Else
                    If optOpcion(3).Value = True Then
                         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "4"
                    End If
                End If
            End If
        End If

         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
         PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, txtCampo.Text
        'codigo de transaccion
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15001"

        FPrincipal.pnlTransaccionLine.Caption = ""

         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_funcbusq", True, "") Then
             PMMapeaGrid sqlconn&, grdFuncionarios, False
             PMChequea sqlconn&
            If Val(grdFuncionarios.Tag) = VGMaxRows% Then
                cmdBoton(1).Enabled = True
            Else
                cmdBoton(1).Enabled = False
            End If
        End If
    
    Case 1  ' Siguientes

        If Val(grdFuncionarios.Tag) > 0 Then
    
            'grdFuncionarios.Row = VGMaxRows%
            grdFuncionarios.Row = grdFuncionarios.Rows - 1
            If optOpcion(0).Value = True Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "1"
                grdFuncionarios.Col = 1
                 PMPasoValores sqlconn&, "@i_funcionario", 0, SQLINT2&, grdFuncionarios.Text
            Else
                If optOpcion(1).Value = True Then
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "2"
                    grdFuncionarios.Col = 2
                     PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, grdFuncionarios.Text
                Else
                    If optOpcion(2).Value = True Then
                         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "3"
                        grdFuncionarios.Col = 3
                         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR&, grdFuncionarios.Text
                    Else
                        If optOpcion(3).Value = True Then
                             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "4"
                            grdFuncionarios.Col = 5
                             PMPasoValores sqlconn&, "@i_cargo", 0, SQLVARCHAR&, grdFuncionarios.Text
                            grdFuncionarios.Col = 1
                             PMPasoValores sqlconn&, "@i_funcionario", 0, SQLINT2&, grdFuncionarios.Text

                        End If
                    End If
                End If
            End If
    
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
             PMPasoValores sqlconn&, "@i_valor", 0, SQLVARCHAR&, txtCampo.Text
            'codigo de transaccion
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15001"
            
            FPrincipal.pnlTransaccionLine.Caption = ""

             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_funcbusq", True, "") Then
                 PMMapeaGrid sqlconn&, grdFuncionarios, True
                 PMChequea sqlconn&
                If Val(grdFuncionarios.Tag) = VGMaxRows% Then
                    cmdBoton(1).Enabled = True
                Else
                    cmdBoton(1).Enabled = False
                End If

            End If
        End If
    
    Case 2  ' Escoger
        
        If Val(grdFuncionarios.Tag) > 0 Then
            VTCols% = grdFuncionarios.Cols - 1
            ReDim VGBusqueda(0 To VTCols%)
            For i% = 1 To grdFuncionarios.Cols - 1
                grdFuncionarios.Col = i%
                VGBusqueda(i%) = grdFuncionarios.Text
            Next i%
            FPrincipal.pnlHelpLine.Caption = ""
            FPrincipal.pnlTransaccionLine.Caption = ""
            Unload FGFuncionarios
            
        End If
        
    Case 3  ' Eliminar
            grdFuncionarios.Col = 2
            VLRespuesta% = MsgBox("Desea eliminar el Funcionario " + grdFuncionarios.Text + " ?", 1 + 32 + 256, "Eliminar Registros")
            If VLRespuesta% = 2 Then
                Exit Sub
            End If
            
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "D"
            grdFuncionarios.Col = 1
             PMPasoValores sqlconn&, "@i_funcionario", 0, SQLINT2&, (grdFuncionarios.Text)
            'codigo de transaccion
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1510"
        
            FPrincipal.pnlTransaccionLine.Caption = ""
            
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_funcionario", True, "Ok...  Eliminación") Then
                 PMChequea sqlconn&
            End If
            cmdBoton_Click (0)

    Case 4  ' Salir
        ReDim VGBusqueda(1)
        Unload FGFuncionarios
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
'*********************************************************
'PROPOSITO: Descripcion de cada Boton
'INPUT   :  Index%  Indice de cada boton
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de Funcionarios"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Búsqueda de los siguientes Funcionarios"
    Case 2
        FPrincipal.pnlHelpLine.Caption = "Escoger el Funcionario actual"
    Case 3
        FPrincipal.pnlHelpLine.Caption = "Eliminar el Funcionario actual"
    Case 4
        FPrincipal.pnlHelpLine.Caption = "Salir de la forma"
    End Select
End Sub

Private Sub Form_Load()
'*********************************************************
'PROPOSITO: Cargar la forma a memoria
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    FGFuncionarios.Left = 550
    FGFuncionarios.Top = 1470
    FGFuncionarios.Height = 4845
    FGFuncionarios.Width = 8490
    
    PMLoadResStrings Me
    PMLoadResIcons Me

End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'PROPOSITO: Descargar de memoria la forma
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************
    
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdFuncionarios_Click()
'*********************************************************
'PROPOSITO: Reasaltar la linea actual del grid
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    If Val((grdFuncionarios.Tag)) >= 1 Then
        PMLineaG grdFuncionarios
    End If
End Sub

Private Sub grdFuncionarios_DblClick()
    If operacion% = Actualizar% Then
        cmdBoton_Click (2)
    Else
        If operacion% = Eliminar% Then
            cmdBoton_Click (3)
        End If
    End If
End Sub

Private Sub grdFuncionarios_GotFocus()
'*********************************************************
'PROPOSITO: Descripcion del grid
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    FPrincipal.pnlHelpLine.Caption = "Funcionarios Existentes"

End Sub

Private Sub optOpcion_Click(Index As Integer, Value As Integer)
'*********************************************************
'PROPOSITO: Describir el valor ha ser buscado
'INPUT   :  Index% Indice del Campo
'OUTPUT  :  ninguno
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
'PROPOSITO: Descripcion de cada Boton
'INPUT   :  Index%  Indice de cada boton
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Código del Funcionario"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Nombre del Funcionario"
    Case 2
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Login del Funcionario"
    Case 3
        FPrincipal.pnlHelpLine.Caption = "Búsqueda por el Cargo del Funcionario"
    End Select
End Sub

Private Sub txtCampo_GotFocus()
'*********************************************************
'PROPOSITO: Descripcion del valor ha ser ingresado
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/94  F.Espinosa          Emisión Inicial
'*********************************************************

    'Seleccionar el texto a la entrada
    txtCampo.SelStart = 0
    txtCampo.SelLength = Len(txtCampo.Text) - 1
    
    If optOpcion(0).Value = True Then
        FPrincipal.pnlHelpLine.Caption = "Código del Funcionario"
    Else
        If optOpcion(1).Value = True Then
            FPrincipal.pnlHelpLine.Caption = "Nombre del Funcionario"
        Else
            If optOpcion(2).Value = True Then
                FPrincipal.pnlHelpLine.Caption = "Login del Funcionario"
            Else
                If optOpcion(3).Value = True Then
                    FPrincipal.pnlHelpLine.Caption = "Cargo del Funcionario"
                End If
            End If
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(KeyAscii As Integer)
'*********************************************************
'PROPOSITO: Control de valores permitidos
'INPUT   :  KeyAscii%   Ascii de la tecla presionada
'OUTPUT  :  ninguno
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
        If optOpcion(1).Value = True Or optOpcion(3).Value Then
            If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) And (KeyAscii% <> 37) Then
                KeyAscii% = 0
            Else
                KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
            End If
        Else
            If optOpcion(2).Value = True Then
                If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) And (KeyAscii% <> 37) Then
                    KeyAscii% = 0
                Else
                    KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
                End If
            End If
        End If
    End If
End Sub

Private Sub txtCampo_LostFocus()
'*********************************************************
'PROPOSITO: Control para que nunca sea nulo el patron de
'           busqueda
'INPUT   :  ninguno
'OUTPUT  :  ninguno
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


