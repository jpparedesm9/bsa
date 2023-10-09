VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FCicProFinal 
   Appearance      =   0  'Flat
   Caption         =   "*Ciclos por Producto Final"
   ClientHeight    =   5325
   ClientLeft      =   885
   ClientTop       =   1350
   ClientWidth     =   9345
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
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9345
   Tag             =   "3007"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   3
      TabIndex        =   2
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin MSGrid.Grid grdCategorias 
      Height          =   3915
      Left            =   15
      TabIndex        =   3
      Top             =   1395
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   6906
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   8400
      Picture         =   "fciclpro.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   11
      Tag             =   "4097"
      Top             =   45
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   8430
      Picture         =   "fciclpro.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   12
      Tag             =   "4098"
      Top             =   1515
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   5
      Left            =   8430
      Picture         =   "fciclpro.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   13
      Tag             =   "4099"
      Top             =   2280
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Index           =   2
      Left            =   8430
      Picture         =   "fciclpro.frx":0876
      Style           =   1  'Graphical
      TabIndex        =   14
      Tag             =   "4100"
      Top             =   3045
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   4
      Left            =   8430
      Picture         =   "fciclpro.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   4545
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   3
      Left            =   8430
      Picture         =   "fciclpro.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   3795
      Width           =   870
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2750
      TabIndex        =   7
      Top             =   615
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   8
      Top             =   600
      WhatsThisHelpID =   5017
      Width           =   570
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   9
      Top             =   300
      WhatsThisHelpID =   5014
      Width           =   1380
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2750
      TabIndex        =   10
      Top             =   315
      Width           =   5590
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2750
      TabIndex        =   5
      Top             =   15
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   6
      Top             =   15
      WhatsThisHelpID =   5019
      Width           =   885
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo por Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   4
      Top             =   1140
      WhatsThisHelpID =   5018
      Width           =   2190
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5385
   End
End
Attribute VB_Name = "FCicProFinal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FCICLPRO.FRM
' NOMBRE LOGICO:    FCicProFinal
' PRODUCTO:         Personalización
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
' Permite el mantenimiento de los ciclos por Producto Final.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 26-Ene-95      Angela Rodríguez    Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLProducto As String
Dim VLCicloAnt As String

Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDNO = 7
    '! removed Const IDCANCEL = 2
    '! removed Const MB_DEFBUTTON1 = 0
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
    Select Case Index%
    Case 0
        'Buscar
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4097"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ciclo_profinal", True, " Ok... Consulta de Ciclos por Producto Final") Then
             PMMapeaGrid sqlconn&, grdCategorias, False
             PMChequea sqlconn&

            grdCategorias.ColWidth(1) = 1000
            grdCategorias.ColWidth(2) = 5750
            
            PLModoInsertar True
            PLLimpiar "=", 3
            PLLimpiar "=", 4
        End If
        

    Case 1
        'Crear
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El código del tipo de capitalización es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
'        If optPosteo(0).Value Then
'            VTPosteo$ = "S"
'        ElseIf optPosteo(1).Value Then
'            VTPosteo$ = "N"
'        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4098"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ciclo_profinal", True, " Ok... Creación de Ciclo por Producto Final") Then
             PMChequea sqlconn&
            cmdBoton_Click (0)
        End If
    
    Case 2
        'Eliminar
        Response = MsgBox("Desea Eliminar el Ciclo por Producto Final?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4100"
             PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ciclo_profinal", True, " Ok... Creación de Ciclo por Producto Final") Then
                 PMChequea sqlconn&
                cmdBoton_Click (0)
             End If
        Else
            Exit Sub
        End If

    Case 3

        'Limpiar
        PLLimpiar ">", 0
        PLModoInsertar True
        txtCampo(0).SetFocus
         
    Case 4
        'Salir
        Unload FCicProFinal
    
    Case 5
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4099"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, VLCicloAnt
         PMPasoValores sqlconn&, "@i_nuevo_ciclo", 0, SQLCHAR, txtCampo(2).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ciclo_profinal", True, " Ok... Actualización de ciclo por Producto Final") Then
             PMChequea sqlconn&
            cmdBoton_Click (0)
        End If

    End Select
End Sub

Private Sub Form_Load()

    '*********************************************************
    'PROPOSITO:  Carga la forma que se encargara de crear
    '           y eliminar categorías por productos finales
    'INPUT   :  ninguno
    'OUTPUT  :  ninguno
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '20/Ene/99  J. Salazar          Emisión Inicial
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FCicProFinal.Left = 0    '15
    FCicProFinal.Top = 0    '15
    FCicProFinal.Width = 9450   '9420
    FCicProFinal.Height = 5900   '5730

 PMLoadResStrings Me
 PMLoadResIcons Me
 PLModoInsertar True
 PMBotonSeguridad FCicProFinal, 5
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(5)
 PMObjetoSeguridad cmdBoton(1)
 PMObjetoSeguridad cmdBoton(2)
 
 FPrincipal.pnlHelpLine.Caption = "FCicProFinal - Version VSS 4"
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCategorias_Click()
    
    grdCategorias.Col = 0
    grdCategorias.SelStartCol = 1
    grdCategorias.SelEndCol = grdCategorias.Cols - 1
    If grdCategorias.Row = 0 Then
        grdCategorias.SelStartRow = 1
        grdCategorias.SelEndRow = 1
    Else
        grdCategorias.SelStartRow = grdCategorias.Row
        grdCategorias.SelEndRow = grdCategorias.Row
    End If

End Sub

Private Sub grdCategorias_DblClick()
Dim VTRow%
Dim Modo As Boolean
    VTRow% = grdCategorias.Row
    grdCategorias.Row = 1
    grdCategorias.Col = 1

    If Trim$(grdCategorias.Text) <> "" Then
        grdCategorias.Row = VTRow%
        PMMarcarRegistro
        
        PLModoInsertar False
        txtCampo(2).Enabled = Not Modo
    End If

End Sub

Private Sub grdCategorias_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para habiliar el botón elimiar"
End Sub

'! Private Sub optPosteo_GotFocus(Index As Integer)
'!     Select Case Index%
'!     Case 0, 1
'!         FPrincipal!pnlHelpLine.Caption = " Estado de las líneas pendientes"
'!     End Select
'!
'! End Sub
'!
Private Sub PLLimpiar(tipo As String, Numero As Integer)
'*************************************************************
' PROPOSITO: Limpia los objetos y el grid, bajo ciertas
'            condiciones.
' INPUT    : Tipo = El símbolo que indica el rango de valores
'                   de los objetos y el grid a ser limpiados.
'            Numero = El número desde el cual se parte el
'                     barrido y limpiado de los objetos
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
Dim i%
    Select Case tipo
        Case "="
            If Numero <= 3 Then
                txtCampo(Numero - 1).Text = ""
                lblDescripcion(Numero - 1).Caption = ""
            ElseIf Numero = 5 Then
                PMLimpiaGrid grdCategorias
            End If
            
        Case ">"
            For i% = Numero To 4
                PLLimpiar "=", i% + 1
            Next i%
        Case "<"
            For i% = Numero To 2 Step -1
                PLLimpiar "=", i% - 1
            Next i%
    End Select

End Sub

Private Sub PLModoInsertar(Modo As Integer)
'*************************************************************
' PROPOSITO: Habilita o deshabilita ciertos objetos de la
'            forma.
' INPUT    : Modo = Entero que indica si el campo se habilita
'                   o no.
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    txtCampo(0).Enabled = Modo 'Sucursal
    txtCampo(1).Enabled = Modo 'Producto final
    txtCampo(2).Enabled = Modo 'Tipo Capitalización
    
    If Modo Then
         PMObjetoSeguridad cmdBoton(1)
         cmdBoton(2).Enabled = Not Modo 'Eliminar
         cmdBoton(5).Enabled = Not Modo 'Actualizar
    Else
         cmdBoton(1).Enabled = Modo 'Crear
         PMObjetoSeguridad cmdBoton(2)
         PMObjetoSeguridad cmdBoton(5)
    End If
    
    'cmdBoton(1).Enabled = Modo 'Crear
    'cmdBoton(2).Enabled = Not Modo 'Eliminar
    'cmdBoton(5).Enabled = Not Modo 'Actualizar
    
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Captura los valores respectivos del grid,
'            y los coloca en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    grdCategorias.Col = 1
    txtCampo(2).Text = grdCategorias.Text
    VLCicloAnt$ = txtCampo(2).Text
    grdCategorias.Col = 2
    lblDescripcion(2).Caption = grdCategorias.Text
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1, 2
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Producto Final [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Código de la Categoría [F5 Ayuda]"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTProFinal$
If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    Case 0
        PLLimpiar "=", 2
        VGOperacion$ = "sp_hp_sucursal"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
            Load FRegistros
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            VLPaso% = True 'No permite que se ejecute el lostfocus, cuando se muestre el catalogo
            FRegistros.Show 1
            
            If VGValores(1) <> "" Then
                txtCampo(0).Text = VGValores(1)
                lblDescripcion(0).Caption = VGValores(2)
                VLPaso% = True
            Else
                VGOperacion$ = ""
                PLLimpiar "=", 1
            End If

        Else
            PLLimpiar "=", 1
            VGOperacion$ = ""
        End If

    Case 1
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            PLLimpiar "<", 3
            VLPaso% = True
            txtCampo(0).SetFocus
            Exit Sub
        End If
    
        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin3"
        Load FRegistros
        While VTFilas% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$

             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                If VTProFinal$ = "0" Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                End If
                
                 PMChequea sqlconn&
                   
                VTFilas% = Val(FRegistros.grdRegistros.Tag)

                FRegistros.grdRegistros.Col = 1
                FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                VTProFinal$ = FRegistros.grdRegistros.Text
            Else
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                VGOperacion$ = ""
            End If
        Wend

        FRegistros.grdRegistros.Row = 1
        FRegistros.Show 1
            
        If VGValores(1) <> "" Then
            txtCampo(1).Text = VGValores(1)
            lblDescripcion(1).Caption = VGValores(2)
            VLProducto$ = VGValores(5)
            VLPaso% = True
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            VGOperacion$ = ""
            VLProducto$ = ""
        End If

    Case 2
        PMCatalogo "A", "cc_ciclo", txtCampo(2), lblDescripcion(2)
        VLPaso% = True
    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 0, 1, 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
If VLPaso% = False Then
    Select Case Index%
    Case 0
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""

        If Trim$(txtCampo(0).Text) = "" Then
            lblDescripcion(0).Caption = ""
            Exit Sub
        End If
        If txtCampo(0).Text >= 32000 Then
            MsgBox "La Sucursal no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
            txtCampo(0).Text = ""
            txtCampo(0).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
        Else
            PLLimpiar "=", 1
            txtCampo(0).SetFocus
            VLPaso% = True
        End If
        
    Case 1
        If Trim$(txtCampo(1).Text) = "" Then
            PLLimpiar "=", 2
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            PLLimpiar "<", 3
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
            ReDim VTArreglo(3) As String
             VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
             PMChequea sqlconn&
            lblDescripcion(1).Caption = VTArreglo(1)
            VLProducto$ = VTArreglo(3)

        Else
            PLLimpiar "=", 2
            txtCampo(1).SetFocus
            VLPaso% = True
        End If
        
    Case 2
        If Trim$(txtCampo(2).Text) = "" Then
            lblDescripcion(2).Caption = ""
            Exit Sub
        End If

        PMCatalogo "V", "cc_ciclo", txtCampo(2), lblDescripcion(2)

        If Trim$(txtCampo(2).Text) = "" And Trim$(lblDescripcion(2).Caption) = "" Then
            txtCampo(2).SetFocus
        End If
        
    End Select
End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


